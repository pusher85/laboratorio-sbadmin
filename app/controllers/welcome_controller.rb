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

end
