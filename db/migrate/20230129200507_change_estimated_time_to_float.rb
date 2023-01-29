class ChangeEstimatedTimeToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :estimated_time, :float
  end
end
