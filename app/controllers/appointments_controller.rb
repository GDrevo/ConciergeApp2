class AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @user = current_user if user_signed_in?
    @appointment.user = @user
    raise
    if @appointment.save
      redirect_to appointment_path(@appointment)
    end
  end

  def show

  end

  def available_cleaners
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.nil? || end_date.nil?
      render json: { error: 'start_date and end_date are required' }, status: :bad_request
      return
    end

    begin
      start_date = DateTime.parse(start_date)
      end_date = DateTime.parse(end_date)
    rescue ArgumentError
      render json: { error: 'start_date and end_date must be valid date' }, status: :bad_request
      return
    end

    @cleaners = Cleaner.all
    @available_cleaners = []
    @cleaners.each do |cleaner|
      if cleaner.availabilities.where("start_time <= ? AND end_time >= ?", end_date, start_date).exists?
        @available_cleaners << cleaner
      end
    end

    if @available_cleaners.empty?
      render json: { error: 'No cleaner available' }, status: :not_found
      return
    end

    render json: @available_cleaners
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :rooms, :service)
  end
end
