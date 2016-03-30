class IntallegatisController < ApplicationController
	

	def index
	end

	def new
		@titolo = "Nuovo allegato per l'intervento"
		@cliente = params[:clienti_id]
		@intervento = params[:interventi_id]
		@allegato = Intallegati.new
	end

	def create
		@cliente = params[:clienti_id]
		@intervento = params[:interventi_id]
		@allegato = Intallegati.new(intallegati_params)
		@allegato.interventi_id = @intervento
		@allegato.autore = current_utenti.id
		if @allegato.save
			redirect_to clienti_interventi_path(:clienti_id => @cliente, :id => @intervento)
		else
			render 'new'
		end
	end

	def show
		#@idallegato =  params[:var_allegato]
		#@allegato = Intallegati.where(id: @idallegato)
	end

	def destroy
		@cliente = params[:clienti_id]
		@intervento = params[:interventi_id]
		@allegato = Intallegati.where(interventi_id: @intervento).find(params[:id])
		@allegato.destroy
		redirect_to clienti_interventi_path(:clienti_id => @cliente, :id => @intervento)
	end


	private

	def intallegati_params
		params.require(:intallegatis).permit(:allegatoint, :titolo, :descrizione)
	end
	
end
