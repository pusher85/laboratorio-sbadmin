class WorksController < ApplicationController
  before_filter :authenticate_utenti!
  before_filter :is_admin?, :except => :show
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@works = Work.all
    #respond_with(@works)
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    redirect_to clienti_interventi_path(:clienti_id => @clienti, :id => @interventi) 
  end

  def show
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    #@work = params[]
    respond_with(@work)
  end

  def new
    @titolo = "Registrazione nuovo Work"
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    @work = Work.new
    #respond_with(@work)
  end

  def edit
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
  end

  def create
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    
    @work = Work.new(work_params)
    @work.interventi_id = params[:interventi_id]
    @work.operator_id = current_utenti.id
    if @work.save
       #respond_with(@interventi)
      redirect_to clienti_interventi_path(:clienti_id => @clienti, :id => @interventi),  notice: "Lavorazione inserita"
    else
      render 'new'
    end
    
  end

  def update
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])

    @work.update(work_params)
    #respond_with(@work)
    redirect_to clienti_interventi_path(:clienti_id => @clienti, :id => @interventi),  notice: "Lavorazione Modificata con successo!"
  end

  def destroy
    @interventi = Interventi.find(params[:interventi_id])
    @clienti = Clienti.find(params[:clienti_id])
    @work.destroy
    #respond_with(@work)
    redirect_to clienti_interventi_path(:clienti_id => @clienti, :id => @interventi), notice: "Rapportino Eliminato"
  end

  # ----------------------------GESTIONE ALLEGATI
  def allega
    @titolo = "Allega Scheda al Work"
    @clienti = Clienti.find(params[:clienti_id])
    #@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])
    @interventi = Interventi.find(params[:interventi_id])
    @work = Work.find(params[:work_id])
    #rescue ActiveRecord::RecordNotFound  
    # flash[:errore] = "Errore nella query - interventi"
    # redirect_to :controller => "welcome", :action => "index"
    #return
  end

  def salva_allegato
    @clienti = Clienti.find(params[:clienti_id])
    #@interventi = Interventi.where(cliente_id: @clienti).find(params[:id])
    @interventi = Interventi.find(params[:interventi_id])
    @work = Work.find(params[:work_id])
    if @work.update(parametri_allegato)
    #if @interventi.update(params[:rapportino])
    #if @interventi.update
      #redirect_to clienti_interventi_path(:clienti_id => @clienti, :id => @interventi), notice: "Scheda Work Caricata con successo"
      redirect_to clienti_interventi_work_path(:clienti_id => @clienti, :interventi_id => @interventi, :id => @work), notice: "Scheda Work Caricata con successo"
      
    else
      render 'allega'
    end
  end

  def elimina_allegato
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    @work = Work.find(params[:work_id])
    @work.schedawork = nil
    @work.save
    redirect_to clienti_interventi_work_path(:clienti_id => @clienti, :interventi_id => @interventi, :id => @work), notice: "Scheda Work EIMINATA con successo"
  end

  def vedi_allegato
    @clienti = Clienti.find(params[:clienti_id])
    @interventi = Interventi.find(params[:interventi_id])
    @work = Work.find(params[:work_id])

    send_file @work.schedawork.path, :type => @work.schedawork.content_type, :disposition => 'inline' 
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:data, :durata, :descrizione, :note, :interventi_id, :operator_id)
    end

    def parametri_allegato
      params.require(:work).permit(:schedawork)
    end
end
