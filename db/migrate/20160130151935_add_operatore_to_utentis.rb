class AddOperatoreToUtentis < ActiveRecord::Migration
  def change
    add_column :utentis, :operatore, :boolean, default: false
  end
end
