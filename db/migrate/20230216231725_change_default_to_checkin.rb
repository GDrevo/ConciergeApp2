class ChangeDefaultToCheckin < ActiveRecord::Migration[7.0]
  def change
    change_column_default :checkins, :duration, from: 0, to: 1
  end
end
