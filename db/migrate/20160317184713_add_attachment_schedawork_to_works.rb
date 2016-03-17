class AddAttachmentSchedaworkToWorks < ActiveRecord::Migration
  def self.up
    change_table :works do |t|
      t.attachment :schedawork
    end
  end

  def self.down
    remove_attachment :works, :schedawork
  end
end
