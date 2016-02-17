class Clienti < ActiveRecord::Base
	has_many :interventis, :dependent => :destroy, :foreign_key => "cliente_id"
	#has_many :interventis, :through => :cliente_id
	has_many :comunicazionis, :through => :interventis
	has_many :contrattis, :dependent => :destroy

	
	has_many :works, through: :interventis

	#gestione autenticazione
	has_one :utenti, :class_name => 'Utenti', :foreign_key => 'clienti_id'
	has_many :interventis
	
	validates :nome, presence: true, length: {minimum: 5 }
	validates :telefono, presence: true, length: {minimum: 9}, numericality: true
end
