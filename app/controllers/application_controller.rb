class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

  protected

    def layout_by_resource
      if devise_controller?
        "login_layout"
      else
        "application"
      end
    end




end
