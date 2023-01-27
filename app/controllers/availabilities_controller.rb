class AvailabilitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    start_date = params.fetch(:start_date, Date.today).to_date

    @availabilities = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
  end
end
