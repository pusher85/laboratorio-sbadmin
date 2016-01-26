class ClientiController < ApplicationController

	#before_action :authenticate_utenti!
	before_filter :authenticate_utenti!
	before_filter :is_admin?
	
	def index
		@clienti = Clienti.all
		@titolo = "Anagrafica Clienti"
	end

	def show
		@titolo = "Dettagli Anagrafica"
		@clienti = Clienti.find(params[:id])
		
		rescue ActiveRecord::RecordNotFound  
		 flash[:errore] = "Errore nella query - clienti"
		 redirect_to :controller => "welcome", :action => "index"
		return
	end

	def new
		@titolo = "Nuovo Cliente"
		@clienti = Clienti.new
	end

	def edit
		@clienti = Clienti.find(params[:id])

		rescue ActiveRecord::RecordNotFound  
		 flash[:errore] = "Errore nella query - clienti"
		 redirect_to :controller => "welcome", :action => "index"
		return
	end

	def create
		@titolo = "Nuovo Cliente"
		@clienti = Clienti.new(clienti_params)
		if @clienti.save
			redirect_to @clienti, notice: "Cliente aggiunto"
		else
			render 'new'
		end
	end

	def update
	  @clienti = Clienti.find(params[:id])
	 
	  if @clienti.update(clienti_params)
	    redirect_to @clienti
	  else
	    render 'edit'
	  end
	end

	def destroy
		@clienti = Clienti.find(params[:id])
	  	@clienti.destroy
	   	#redirect_to clienti_path
	   	redirect_to clienti_index_path, notice: "Cliente eliminato"
	end

	private
		def clienti_params
			params.require(:clienti).permit(:nome, :piva, :codfisc, :email, :telefono, :note)
		end

		

end
