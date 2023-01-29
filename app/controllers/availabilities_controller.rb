class AvailabilitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    start_date = params.fetch(:start_date, Date.today).to_date

    @availabilities = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    @appointments = Appointment.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    @availabilities = @availabilities + @appointments
  end

  def new
    @cleaner = current_cleaner
    @availability = Availability.new
  end

  def create
    @availability = Availability.new(availability_params)
    @availability.cleaner = current_cleaner
    @availability.save
    redirect_to cleaner_availabilities_path
  end

  private

  def availability_params
    params.require(:availability).permit(:start_time, :end_time)
  end
end
