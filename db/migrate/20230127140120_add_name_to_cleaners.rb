class AddNameToCleaners < ActiveRecord::Migration[7.0]
  def change
    add_column :cleaners, :name, :string
    add_column :cleaners, :description, :string
    add_column :cleaners, :phone, :integer
    add_column :cleaners, :gender, :string
    add_column :cleaners, :location, :string
    add_column :cleaners, :qualification, :string
    add_column :cleaners, :experience, :string
    add_column :cleaners, :days_per_week, :integer
    add_column :cleaners, :work_permit?, :boolean
    add_column :cleaners, :full_time?, :boolean
    add_column :cleaners, :confirmed?, :boolean
  end
end
