class AddTimeAndPriceToCheckin < ActiveRecord::Migration[7.0]
  def change
    add_column :checkins, :duration, :integer, default: 0
    add_column :checkins, :price, :integer, default: 25
  end
end
