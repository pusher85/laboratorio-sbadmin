class Contratti < ActiveRecord::Base
	belongs_to :clienti

	validates :acquisto, presence: true
	validates :ore, presence: true, numericality: { only_integer: true }
end
