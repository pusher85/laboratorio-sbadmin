class RemoveFieldNameFromComunicazionis < ActiveRecord::Migration
  def change
    remove_column :comunicazionis, :interventi_id, :text
  end
end
