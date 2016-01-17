class Interventi < ActiveRecord::Base
  #belongs_to :clienti, :foreign_key => "cliente_id"
  belongs_to :clienti
  has_many :comunicazionis, :dependent => :destroy

  validates :data, presence: true
  validates :intervento, presence: true, length: {minimum: 5 }
  validates :durata, presence: true

end
