class CreateClientis < ActiveRecord::Migration
  def change
    create_table :clientis do |t|
      t.string :nome
      t.string :piva
      t.string :codfisc
      t.text :email
      t.string :telefono
      t.text :note

      t.timestamps
    end
  end
end
