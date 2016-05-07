class AddCampi3ToClientis < ActiveRecord::Migration
  def change
    add_column :clientis, :cap, :text
  end
end
