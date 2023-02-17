class ChangeAgainColumnTypeInCheckins < ActiveRecord::Migration[7.0]
  def change
    rename_column :checkins, :checkin_type, :check_type
  end
end
