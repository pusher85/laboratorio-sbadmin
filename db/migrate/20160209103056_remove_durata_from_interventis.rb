class RemoveDurataFromInterventis < ActiveRecord::Migration
  def change
    remove_column :interventis, :durata, :integer
  end
end
