class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
    	t.integer :interventi_id
    	t.integer :operator_id
      t.date :data
      t.integer :durata
      t.text :descrizione
      t.text :note

      t.timestamps
    end
  end
end

