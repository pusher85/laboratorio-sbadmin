class UtentisController < ApplicationController

	#before_action :authenticate_utenti!
	before_filter :authenticate_utenti!
	before_filter :is_admin?
	
	def index
		@titolo = "Login utenti censite"
		#@utenti = Utenti.all
		@utenti = Utenti.select('utentis.id, utentis.nome, utentis.email, utentis.admin, utentis.clienti_id, clientis.nome AS nomecliente').joins('LEFT OUTER JOIN clientis ON utentis.clienti_id = clientis.id')
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

	def show
		@titolo = "Dettagli Login"
		#@utenti = Utenti.find(params[:id])
		@utenti = Utenti.select('utentis.*, clientis.nome AS nomecliente').joins('LEFT OUTER JOIN clientis ON utentis.clienti_id = clientis.id').find(params[:id])
	end

	def edit
		@titolo = "Modifica Login"
		@utenti = Utenti.find(params[:id])
		@clienti = Clienti.all
	end

	def update
		@utenti = Utenti.find(params[:id])
		@clienti = Clienti.all

		if params[:utentis][:password].blank?
			params[:utentis].delete(:password)
		end

		if @utenti.update(utenti_params)
			redirect_to @utenti
		else
			render 'edit'
		end
	end



	private
		def utenti_params
			params.require(:utentis).permit(:nome, :email, :clienti_id, :password)
		end

end
