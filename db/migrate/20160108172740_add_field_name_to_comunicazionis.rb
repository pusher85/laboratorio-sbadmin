class AddFieldNameToComunicazionis < ActiveRecord::Migration
  def change
    add_column :comunicazionis, :interventi_id, :text
  end
end
