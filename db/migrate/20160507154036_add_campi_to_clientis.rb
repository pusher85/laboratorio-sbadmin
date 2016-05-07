class AddCampiToClientis < ActiveRecord::Migration
  def change
    add_column :clientis, :indirizzo, :text#,
    #add_column :clientis, :citta, :text,
    #add_column :clientis, :cap, :text,
    #add_column :clientis, :provincia, :text,
    #add_column :clientis, :telefonofisso, :text
  end
end
