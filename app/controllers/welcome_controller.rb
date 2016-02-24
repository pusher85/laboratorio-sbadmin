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

    
  end



  ###############################



end
