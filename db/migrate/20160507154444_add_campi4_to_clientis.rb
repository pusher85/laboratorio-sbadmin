class AddCampi4ToClientis < ActiveRecord::Migration
  def change
    add_column :clientis, :provincia, :text
  end
end
