class ComunicazioniController < ApplicationController
	def index
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.find(params[:interventi_id])

		
		

	end


	def show
	end


	def new
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.find(params[:interventi_id])
		@comunicazioni = Comunicazioni.new
	end


	def edit
	end


	def create
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.find(params[:interventi_id])
		@comunicazioni = Comunicazioni.new(parametri_comunicazioni)

		if @comunicazioni.save
			@messaggio = parametri_comunicazioni[:testo]
			@telefono = parametri_comunicazioni[:destinatario]
						
			#@sms = Skuby::Gateway.send_sms(@messaggio, @telefono)
			#if @sms.success? #=> true
				#redirect_to clienti_interventi_index_path
				#redirect_to clienti_interventi_index_path(:esitosms => @sms.success)
			#	redirect_to clienti_interventi_path(:id => @interventi)
			#end

			redirect_to clienti_interventi_path(:id => @interventi)
		else
			render 'new'
		end
	end


	def update
	end


	def destroy
		@clienti = Clienti.find(params[:clienti_id])
		@interventi = Interventi.find(params[:interventi_id])
		@comunicazioni = Comunicazioni.find(params[:id])
		@comunicazioni.destroy
		redirect_to clienti_interventi_path(params[:clienti_id])
	end



	private
		def parametri_comunicazioni
			params.require(:comunicazioni).permit(:interventi_id, :tipo, :destinatario, :testo, :interventi_id)
		end






end
