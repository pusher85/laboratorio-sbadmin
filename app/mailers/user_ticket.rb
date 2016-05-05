class UserTicket < ActionMailer::Base
  default from: "from@example.com"


  def richiesta(cliente)
  	@nome_cliente = cliente
  	@destinatario = 'info@francescobucci.it'
  	@oggetto = "Nuovo ticket da un cliente"
  	@url  = 'http://example.com/login'

  	#delivery_options = { user_name: francescobucci,
    #                     password: duvvudutko62,
    #                     address: smtp.gmail.com,
    #                     port: 587,
    #                     authentication: plain  }

  	#mail(to: @destinatario, subject: @oggetto, delivery_method_options: delivery_options)
  	mail(to: @destinatario, subject: @oggetto)

  end




end
