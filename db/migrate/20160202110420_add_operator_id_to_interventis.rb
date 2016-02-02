class AddOperatorIdToInterventis < ActiveRecord::Migration
  def change
    add_column :interventis, :operator_id, :integer
  end
end
