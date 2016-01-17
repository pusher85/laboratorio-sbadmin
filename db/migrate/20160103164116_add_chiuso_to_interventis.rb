class AddChiusoToInterventis < ActiveRecord::Migration
  def change
    add_column :interventis, :chiuso, :boolean
  end
end
