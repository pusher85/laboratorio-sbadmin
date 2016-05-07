class AddCampi5ToClientis < ActiveRecord::Migration
  def change
    add_column :clientis, :telefonofisso, :text
  end
end
