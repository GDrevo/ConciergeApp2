class AvailabilitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    availabilities = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    @availabilities = availabilities.where(cleaner_id: params[:cleaner_id])
    # raise
    appointments = Appointment.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    @appointments = appointments.where(cleaner_id: params[:cleaner_id])
    @availabilities += @appointments
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
    params.require(:availability).permit(:start_time, :end_time, :cleaner_id)
  end
end
