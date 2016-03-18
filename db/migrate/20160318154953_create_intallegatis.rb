class CreateIntallegatis < ActiveRecord::Migration
  def change
    create_table :intallegatis do |t|
      t.integer :interventi_id
      t.string :titolo
      t.text :descrizione
      t.integer :autore

      t.timestamps
    end
  end
end
