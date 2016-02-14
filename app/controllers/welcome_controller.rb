class WelcomeController < ApplicationController
  

  before_filter :is_operatore?, :only => :assegnati
  before_filter :is_admin?, :only => :aperti
  before_filter :authenticate_utenti!, :only => :elenco
  before_filter :is_user?, :only => :elenco


  def index
  	@conta_aperti = Interventi.where(chiuso: false).count
  	@credito_skebby = Skuby::Credit.balance

  end


  def aperti
  	@titolo =" Interventi in corso"
  	@aperti = Interventi.select("interventis.data, interventis.intervento, clientis.nome, interventis.cliente_id, interventis.id").joins('INNER JOIN clientis ON interventis.cliente_id = clientis.id').where(chiuso: false).order("data ASC")
  end


	def assegnati
    @titolo = "Ciao #{current_utenti.nome},  questi sono i tuoi interventi."
		@assegnati = Interventi.where(operator_id: current_utenti.id) 
	end

  def elenco

  end  

  def justone
    @cod_cliente = params[:justone][:cod_cli]
    @cod_intervento = params[:justone][:cod_int]

    if @cod_cliente.blank? || @cod_intervento.blank?
      flash[:danger] = 'Controlla i parametri inseriti. La ricerca non ha prodotto risultati'
      redirect_to :controller => "welcome", :action => "prelogin"
	return
    end

    @intervento = Interventi.where(:cliente_id => @cod_cliente, :codice => @cod_intervento ).first
    
    if !@intervento
      flash[:danger] = 'Errore nella query - cerca justone'
      redirect_to:controller => "welcome", :action => "prelogin"
	return
    end     
    

  end



  ###############################



end
