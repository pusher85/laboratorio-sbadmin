class Work < ActiveRecord::Base
	belongs_to :interventi

	#creata per relazione clienti-works
	has_one :clienti, through: :interventis

	validates :data, presence: true
	validates :durata, presence: true, numericality: true
	validates :descrizione, presence: { message: "Inserisci una descrizione dei lavori effettuati"}, length: {minimum: 5, message: "la descrizione ha meno di 5 caratteri"}
		
end
