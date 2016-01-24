class AddNomeToUtentis < ActiveRecord::Migration
  def change
    add_column :utentis, :nome, :string
  end
end
