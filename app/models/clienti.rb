class Clienti < ActiveRecord::Base
	has_many :interventi, :dependent => :destroy, :foreign_key => "cliente_id"
	#has_many :comunicazioni, :through => :interventi, :dependent => :destroy
	has_many :contratti, :dependent => :destroy
	has_many :works, :through => :interventi, :dependent => :destroy
	
	#gestione autenticazione
	has_one :utenti, :foreign_key => 'clienti_id', :dependent => :destroy
	
	validates :nome, presence: true, length: {minimum: 5 }
	validates :telefono, presence: true, length: {minimum: 9}, numericality: true
end
