class Work < ActiveRecord::Base
	belongs_to :interventi

	#creata per relazione clienti-works
	has_one :clienti, through: :interventis
end
