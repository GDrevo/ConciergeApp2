class AddCheckinToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :checkin_type, :string
    add_column :appointments, :pack, :string
    add_column :appointments, :checkin_start_time, :datetime
    add_column :appointments, :checkin_end_time, :datetime
    add_reference :appointments, :checkin_cleaner
    add_column :appointments, :checkout_start_time, :datetime
    add_column :appointments, :checkout_end_time, :datetime
    add_reference :appointments, :checkout_cleaner
    add_foreign_key :appointments, :cleaners, column: :checkin_cleaner_id
    add_foreign_key :appointments, :cleaners, column: :checkout_cleaner_id
  end
end
