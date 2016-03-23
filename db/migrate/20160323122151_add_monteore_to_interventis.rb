class AddMonteoreToInterventis < ActiveRecord::Migration
  def change
    add_column :interventis, :monteore, :boolean
  end
end
