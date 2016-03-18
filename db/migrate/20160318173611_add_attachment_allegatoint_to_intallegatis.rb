class AddAttachmentAllegatointToIntallegatis < ActiveRecord::Migration
  def self.up
    change_table :intallegatis do |t|
      t.attachment :allegatoint
    end
  end

  def self.down
    remove_attachment :intallegatis, :allegatoint
  end
end
