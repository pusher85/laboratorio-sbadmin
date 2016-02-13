class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #dichiarazione variabili per stato autenticazione
  before_filter :veriabili

  #before_action :authenticate_utenti!

  #I18n.locale = :it
	
  #pagina custom per devise login
  layout :layout_by_resource


	#per login con nome
	before_action :configure_permitted_parameters, if: :devise_controller?  

	def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nome
    devise_parameter_sanitizer.for(:account_update) <<:nome
  end


  #funzione per verificare se l'utente loggato è amministratore - utilizzata nei controller protetti
  def is_admin?
    if current_utenti.admin?
      true
    else
      redirect_to root_path
    end
  end

  def is_operatore?
    #if current_utenti.operatore? || current_utenti.admin?
    if utenti_signed_in? && ( current_utenti.operatore? || current_utenti.admin?)
      true
    else
      redirect_to root_path
    end
  end

  def is_user?
    if utenti_signed_in? && !current_utenti.admin? && !current_utenti.operatore?
      true
    else
      redirect_to root_path
    end
  end

  
  protected

    def layout_by_resource
      #se richiesta pagina di login reindirizza a welcome#login_layout
      #if devise_controller? && params[:action] == 'new'
      if params[:controller] == 'devise/sessions' && (params[:action] == 'new' || params[:action] == 'create')
        "login_layout"
        #logger.info "richiesto login - reindirizzato a nuova pagina login"
      #elsif devise_controller? && params[:action] == 'edit'
      #  redirect_to edit_utenti_password_path
      #  "password/edit"
      #edit_utenti_password_path
      
      else
       "application"
      end
    end

    ###########################################################################################################

    def veriabili
      @sono_guest = if !utenti_signed_in?
                      true
                    else
                      false
                    end

      @sono_loggato = if utenti_signed_in?
                        true
                      else
                        false
                      end

      @sono_admin = if utenti_signed_in? && current_utenti.admin?
                      true
                    else
                      false
                    end

      @sono_operatore = if utenti_signed_in? && (current_utenti.admin? || current_utenti.operatore?)
                          true
                        else
                          false
                        end
      
      @sono_user = if utenti_signed_in? && !current_utenti.admin? && !current_utenti.operatore?
                      true 
                    else 
                      false
                    end
    end

    ###########################################################################################################

end
