class AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @user = current_user if user_signed_in?
    @appointment.user = @user
    cleaner_availability = @appointment.cleaner.availabilities.where("start_time <= ? AND end_time >= ?", @appointment.end_time, @appointment.start_time).first
    # TO DO: reduce the cleaner_availability by the estimated time of the @appointment and save it
    calculate_price_and_time(@appointment)
    if cleaner_availability.start_time == @appointment.start_time
      cleaner_availability.start_time += @appointment.estimated_time.hours
    elsif cleaner_availability.end_time == @appointment.end_time
      cleaner_availability.end_time -= @appointment.estimated_time.hours
    else
      new_availability = Availability.new(start_time: @appointment.end_time, end_time: cleaner_availability.end_time)
      new_availability.cleaner = @appointment.cleaner
      cleaner_availability.end_time = @appointment.start_time
      new_availability.save
    end

    if @appointment.save
      cleaner_availability.save
      redirect_to appointment_path(@appointment)
    end
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

  def show
    @appointment = Appointment.find(params[:id])
  end

  private

  def calculate_price_and_time(appointment)
    roomsprice = appointment.rooms.to_i
    roomstime = appointment.rooms.to_i

    case appointment.service
    when "Basic"
      serviceprice = 20
      servicetime = 1 / 3.0
    when "Medium"
      serviceprice = 30
      servicetime = 2 / 3.0
    else
      serviceprice = 40
      servicetime = 4 / 3.0
    end

    estimated_price = roomsprice * serviceprice
    estimated_time = ((roomstime * servicetime) * 2).round / 2.0
    appointment.estimated_time = 1.0 * estimated_time
    appointment.price = estimated_price
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :rooms, :service, :cleaner_id)
  end
end
