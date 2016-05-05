class WelcomeController < ApplicationController
  

  before_filter :is_operatore?, :only => :assegnati
  before_filter :is_admin?, :only => :aperti
  before_filter :authenticate_utenti!, :only => :elenco
  before_filter :is_user?, :only => :elenco


  def index
    if @sono_guest
      redirect_to :controller => "welcome", :action => "prelogin"
      return
    end
  	@conta_aperti = Interventi.where(chiuso: false).count
  	@credito_skebby = Skuby::Credit.balance

  end


  def aperti
  	@titolo =" Interventi in corso"
  	#@aperti = Interventi.select("interventis.data, interventis.intervento, clientis.nome, interventis.cliente_id, interventis.id").joins('INNER JOIN clientis ON interventis.cliente_id = clientis.id').where(chiuso: false).order("data ASC")
    @interventi = Interventi.where(chiuso: false)    
  end


	def assegnati
    @titolo = "Ciao #{current_utenti.nome},  questi sono i tuoi interventi."
		@assegnati = Interventi.where(operator_id: current_utenti.id) 
	end

  def elenco
    @titolo ="I miei Interventi"
    @interventi = Interventi.where(cliente_id: current_utenti.clienti_id)
  end  


  def prelogin
    if !@sono_guest
      redirect_to root_path
      return
    end    

  end

  def justone
    if !@sono_guest
      redirect_to root_path
      return
    end
    
    @cod_cliente = params[:justone][:cod_cli]
    @cod_intervento = params[:justone][:cod_int]

    if @cod_cliente.blank? || @cod_intervento.blank?
      flash[:danger] = 'Controlla i parametri inseriti. La ricerca non ha prodotto risultati'
      redirect_to :controller => "welcome", :action => "prelogin"
      return
    end

    @intervento = Interventi.where(:cliente_id => @cod_cliente, :codice => @cod_intervento ).first
    
    if !@intervento
      flash[:danger] = 'Intervento non trovato. Controlla i parametri'
      redirect_to :controller => "welcome", :action => "prelogin"
      return
    end

    @cliente = Clienti.find(@cod_cliente)

    ########### Gestione stati di lavorazione

    @stato_data_inserimento = @intervento.created_at
    @stato_tecnico_presente = 'assegnato' if @intervento.operator_id
    @stato_tecnico = Utenti.find(@intervento.operator_id) if @intervento.operator_id 
    @stato_numero_works =  @intervento.works.count

    @tecnico = Utenti.find(@intervento.operator_id) if @intervento.operator_id 

  end

  def richiedi
    if !@sono_user
      redirect_to root_path
      return
    end

    @titolo = "Richiedi Intervento"
    @interventi = Interventi.new
    @clienti = current_utenti.clienti_id

    # ------------------------------------------------
    # Calcolo ore residue per contratti acquistati
    @contrattis = Contratti.where(clienti_id: @clienti)
    @acquistate = Contratti.where(clienti_id: @clienti).sum(:ore)
    totaleore = Array.new
    Interventi.where(cliente_id: @clienti, :monteore => '1').each do |int|
      totaleore.push(Work.where(:interventi_id => int.id).sum(:durata))
    end
    @ore_usate = totaleore.sum
    @ore_rimanenti = @acquistate-@ore_usate
    # ------------------------------------------------

  end


  #metodo per salvataggio richiesta di intervento
  def richiesta
    @clienti = current_utenti.clienti_id
    @interventi = Interventi.new(parametri_intervento)
    @interventi.codice = SecureRandom.hex(2)
    @nomecliente = current_utenti.nome
    if @interventi.save
      #invio email
      UserTicket.richiesta(@nomecliente).deliver
      flash[:notice] = 'Nuova richiesta di  intervento inserita !!'
      redirect_to welcome_elenco_path
    else
      render 'richiedi'
    end
  end


  ###############################
  private

  def parametri_intervento
    params.require(:interventi).permit(:cliente_id, :data, :apparecchiatura, :intervento, :note, :chiuso, :codice, :operator_id, :monteore)
  end


end
