class AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user if user_signed_in?
    case @appointment.pack
    when "Check in/out"
      create_checkin_appointment
    when "Cleaning"
      create_cleaning
    when "Check in/out & Cleaning"
      create_checkin_appointment
      create_cleaning
    end
  end

  def create_checkin_appointment
    case @appointment.checkin_type
    when "Check in"
      create_check_in
    when "Check out"
      create_check_out
    when "Check in & out"
      create_check_in
      create_check_out
    end
  end

  def create_check_in
    # TODO: create a new instance of Checkin with type: "checkin"
    @checkin = Checkin.new(checkin_params)
    @checkin.user = current_user if user_signed_in?
    raise
  end

  def create_check_out
    # TODO: create a new instance of Checkin with type: "checkout"
    raise
  end

  def create_cleaning
    end_time = @appointment.end_time
    start_time = @appointment.start_time
    return unless @appointment.cleaner

    all_availabilities = @appointment.cleaner.availabilities
    cleaner_availability = all_availabilities.where("start_time <= ? AND end_time >= ?", end_time, start_time).first
    return unless cleaner_availability

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
    return unless @appointment.save

    cleaner_availability.save
    redirect_to appointment_path(@appointment)
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

  # ISSUE TO FIX NOW: checkin params, unknown checkin_type for Checkin
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :rooms, :service, :cleaner_id, :pack, :checkin_type, :checkin_start_time, :checkin_end_time, :checkin_cleaner_id, :checkout_start_time, :checkout_end_time, :checkout_cleaner_id)
  end

  def checkin_params
    checkin_params = params.require(:appointment).permit(:type, :checkin_start_time, :checkin_end_time, :checkin_cleaner_id, :checkout_start_time, :checkout_end_time, :checkout_cleaner_id)
    checkin_params.transform_keys { |key| key.gsub("checkin_", "") }
  end
end
