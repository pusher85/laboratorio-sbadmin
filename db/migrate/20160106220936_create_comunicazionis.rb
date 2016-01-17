class CreateComunicazionis < ActiveRecord::Migration
  def change
    create_table :comunicazionis do |t|
      t.references :interventi, index: true
      t.text :tipo
      t.datetime :data
      t.text :destinatario
      t.text :testo

      t.timestamps
    end
  end
end
