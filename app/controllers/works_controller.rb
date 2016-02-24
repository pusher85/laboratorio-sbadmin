class WorksController < ApplicationController
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

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:data, :durata, :descrizione, :note, :interventi_id, :operator_id)
    end
end
