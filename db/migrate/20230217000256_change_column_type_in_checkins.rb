class ChangeColumnTypeInCheckins < ActiveRecord::Migration[7.0]
  def change
    rename_column :checkins, :type, :checkin_type
  end
end
