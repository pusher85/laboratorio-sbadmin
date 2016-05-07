class AddCampi2ToClientis < ActiveRecord::Migration
  def change
    add_column :clientis, :citta, :text
  end
end
