class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :cleaner
  validate :validate_cleaner_availability
  validates :start_time, presence: true
  validates :end_time, presence: true

  private

  def validate_cleaner_availability
    cleaner_availabilities = cleaner.availabilities.where("start_time <= ? AND end_time >= ?", end_time, start_time)
    errors.add(:cleaner, "not available at that time") if cleaner_availabilities.empty?
  end
end
