class AddOperatorIdToInterventis < ActiveRecord::Migration
  def change
  	unless column_exists? :interventis, :operator_id
    	add_column :interventis, :operator_id, :integer
  	end
  end
end
