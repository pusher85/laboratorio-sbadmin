class UtentisController < ApplicationController

	before_action :authenticate_utenti!
	
	def index
		@titolo = "Login utenti censite"
		@utenti = Utenti.all
	end

	def new
		@titolo = "Creazione nuova login"
		@utenti = Utenti.new
		#@clienti = Clienti.all
		@clienti = Clienti.where('clientis.id not in ( select clienti_id from utentis where clienti_id is not null )')
	end

	def create
		@titolo = "Creazione nuova login"
		#@clienti = Clienti.all
		@clienti = Clienti.all
		@utenti = Utenti.new(utenti_params)
		if @utenti.save
			redirect_to @utenti, notice: "Utente aggiunto"
		else
			render 'new'
		end
	end


	private
		def utenti_params
			params.require(:utentis).permit(:nome, :email, :clienti_id, :password)
		end

end
