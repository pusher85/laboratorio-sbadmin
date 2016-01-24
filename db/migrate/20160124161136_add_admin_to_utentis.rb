class AddAdminToUtentis < ActiveRecord::Migration
  def change
    add_column :utentis, :admin, :boolean, default: false
  end
end
