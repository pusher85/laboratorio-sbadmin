class AddApprovedToUtenti < ActiveRecord::Migration
  def change
    add_column :utentis, :approved, :boolean
  end
end
