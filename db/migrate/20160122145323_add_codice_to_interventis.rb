class AddCodiceToInterventis < ActiveRecord::Migration
  def change
    add_column :interventis, :codice, :string
  end
end
