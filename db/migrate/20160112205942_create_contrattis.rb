class CreateContrattis < ActiveRecord::Migration
  def change
    create_table :contrattis do |t|
      t.integer :clienti_id
      t.date :acquisto
      t.integer :ore
      t.text :note

      t.timestamps
    end
  end
end
