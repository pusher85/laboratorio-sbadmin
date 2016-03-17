class Work < ActiveRecord::Base

	has_attached_file :schedawork
	validates_attachment_content_type :schedawork, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

	belongs_to :interventi

	#creata per relazione clienti-works
	has_one :clienti, through: :interventis

	validates :data, presence: true
	validates :durata, presence: true, numericality: true
	validates :descrizione, presence: { message: "Inserisci una descrizione dei lavori effettuati"}, length: {minimum: 5, message: "la descrizione ha meno di 5 caratteri"}
		
end
