class Interventi < ActiveRecord::Base
  #belongs_to :clienti, :foreign_key => "cliente_id"
  belongs_to :clienti
  has_many :comunicazionis, :dependent => :destroy
  has_many :works, :dependent => :destroy
  #allegati intervento
  has_many :intallegatis, :dependent => :destroy
  #has_attached_file :rapportino#, { url: "/system/:hash.:extension", hash_secret: "longSecretString" }
  
  #do_not_validate_attachment_file_type :rapportino
  #validates_attachment_content_type :rapportino, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  

  #validates_attachment_content_type :rapportino, content_type: /.pdf\Z/
  #validates_attachment_file_name :rapportino, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/, /gif\Z/, /jpg\Z/]
  #validates_attachment_content_type :rapportino, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  #validates_attachment :rapportino, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

  #do_not_validate_attachment_file_type :rapportino


  #has_one :utenti, :foreign_key => "operator_id"

  validates :data, presence: true
  validates :intervento, presence: true, length: {minimum: 5 }
  #validates :durata, presence: true

end
