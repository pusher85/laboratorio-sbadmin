class Intallegati < ActiveRecord::Base
	belongs_to :interventi
	has_attached_file :allegatoint
	validates_attachment_content_type :allegatoint, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
end
