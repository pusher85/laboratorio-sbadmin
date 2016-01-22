class Comunicazioni < ActiveRecord::Base
  belongs_to :interventi


  validates :destinatario, presence: true, format: { with: /\A(39)\d\d\d\d\d\d\d\d\d/, message: "Il numero di telefono deve iniziare con il prefisso internazionale '39' e contenere almeno 11 numeri " }
  #validates_numericality_of :destinatario, presence: true, format: { with: /G(39)/, message: "Il numero di telefono deve iniziare con il prefisso internazionale '39' " }
  validates :testo, presence: { message: "Inserisci il messaggio da inviare"}, length: {minimum: 5, message: "Il testo della comunicazione ha meno di 5 caratteri"}
end
