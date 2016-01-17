class CreateInterventis < ActiveRecord::Migration
  def change
    create_table :interventis do |t|
      t.references :cliente, index: true
      t.date :data
      t.string :apparecchiatura
      t.text :intervento
      t.integer :durata
      t.text :note

      t.timestamps
    end
  end
end
