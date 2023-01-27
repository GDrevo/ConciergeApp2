class AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @appointment = Appointment.new
  end
end
