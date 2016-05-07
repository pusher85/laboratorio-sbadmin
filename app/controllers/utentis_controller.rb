class UtentisController < ApplicationController

	#before_action :authenticate_utenti!
	before_filter :authenticate_utenti!
	before_filter :is_admin?
	
	def index
		@titolo = "Login utenti censite"
		#@utenti = Utenti.all
		@utenti = Utenti.select('utentis.id, utentis.nome, utentis.email, utentis.admin, utentis.operatore, utentis.clienti_id, clientis.nome AS nomecliente').joins('LEFT OUTER JOIN clientis ON utentis.clienti_id = clientis.id')
	end

	def new
		@titolo = "Creazione nuova login"
		@utenti = Utenti.new

		#params[:varcliente] ? @miocliente = Clienti.find(params[:varcliente]) : end #@miocliente = '0'
		@miocliente = Clienti.find(params[:varcliente]) if params[:varcliente]

		@clienti = Clienti.where('clientis.id not in ( select clienti_id from utentis where clienti_id is not null )')
	end

	def create
		@titolo = "Creazione nuova login"
		@clienti = Clienti.all
		@utenti = Utenti.new(utenti_params)
		if @utenti.save
			redirect_to utentis_path, notice: "Utente aggiunto"
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

	def destroy
		@utenti = Utenti.find(params[:id])
		
		#controllo se l'utente eliminato era un operatore. Se era operatore, agli interventi che gli erano stati assegnati sarà azzerato il codice operatore
		if @utenti.operatore
			@codoperatore = @utenti.id
			@resetoperatoreinterventi = Interventi.where(operator_id: @codoperatore)
			
			@resetoperatoreinterventi.each do |int|
				int.operator_id = nil
				int.save
			end

			@resetoperatoreworks = Work.where(operator_id: @codoperatore)
			@resetoperatoreworks.each do |w|
				w.operator_id = nil
				w.save
			end

			@resetopertoreintallegati = Intallegati.where(autore: @codoperatore)
			@resetopertoreintallegati.each do |alleg|
				alleg.autore = nil
				alleg.save
			end

		end

		@utenti.destroy
		redirect_to utentis_path, notice: "Login e relative dipendenze eliminata con successo!"
	end


	private
		def utenti_params
			params.require(:utentis).permit(:nome, :email, :clienti_id, :password, :admin, :operatore)
		end

end
