class AddColumnsToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :rooms, :integer
    add_column :appointments, :service, :string
    add_column :appointments, :estimated_time, :integer
    add_column :appointments, :price, :integer
  end
end
