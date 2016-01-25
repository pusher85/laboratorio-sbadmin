class AddClientiIdToUtentis < ActiveRecord::Migration
  def change
    add_column :utentis, :clienti_id, :integer
  end
end
