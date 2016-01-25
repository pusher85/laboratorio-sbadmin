class InterventiController < ApplicationController

	before_action :authenticate_utenti!

	#per ispezionare i valori passati in POST
	#render plain: params[:intervento].inspect
	
	def index
		@titolo = "Elenco Interventi"
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.select("interventis.id, interventis.data, interventis.intervento, COUNT(comunicazionis.id) AS tot_comunicazioni, interventis.chiuso").joins('LEFT OUTER JOIN comunicazionis ON interventis.id = comunicazionis.interventi_id').where(cliente_id: params[:clienti_id]).group("interventis.id").order("interventis.data DESC")
		#@aperti = Interventi.select("interventis.data, interventis.intervento, clientis.nome, interventis.cliente_id, interventis.id").joins('INNER JOIN clientis ON interventis.cliente_id = clientis.id').where(chiuso: false).order("data ASC")
	end


	def show
		@titolo = "Dettaglio Intervento"
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])

		rescue ActiveRecord::RecordNotFound  
		 flash[:errore] = "Errore nella query - interventi"
		 redirect_to :controller => "welcome", :action => "index"
		return

	end


	def new
		@titolo = "Nuovo Intervento"
		@interventi = Interventi.new
		@clienti = Clienti.find(params[:clienti_id])	
		#@clienti = Clienti.find(params[:id])
	end


	def edit
		@titolo = "Modifica Intervento"
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])
		rescue ActiveRecord::RecordNotFound  
		 flash[:errore] = "Errore nella query - interventi"
		 redirect_to :controller => "welcome", :action => "index"
		return
	end


	def create
		@clienti = Clienti.find(params[:clienti_id])

		@interventi = Interventi.new(parametri_intervento)
		@interventi.codice = SecureRandom.hex(2)
		if @interventi.save
			redirect_to clienti_interventi_path(:id => @interventi)
		else
			render 'new'
		end
	end


	def update
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])
		if @interventi.update(parametri_intervento)
			redirect_to clienti_interventi_path(:id => @interventi)
		else
			render 'edit'
		end
	end


	def destroy
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])
		@interventi.destroy
		redirect_to clienti_interventi_index_path(params[:clienti_id])
	end

	def sms
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.where(cliente_id: @clienti).find(params[:interventi_id])
		@sms = Skuby::Gateway.send_sms('Messaggio di prova', '393291529641')
		if @sms.success? #=> true
			redirect_to clienti_interventi_index_path
			#redirect_to clienti_interventi_index_path(:esitosms => @sms.success)
		end
	end

	
	private
		def parametri_intervento
			params.require(:interventi).permit(:cliente_id, :data, :apparecchiatura, :intervento, :durata, :note, :chiuso, :codice)
		end

		

end
