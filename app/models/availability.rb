class Availability < ApplicationRecord
  belongs_to :cleaner
  validates :start_time, presence: true
  validates :end_time, presence: true
end
