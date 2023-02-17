class CheckinsController < ApplicationController
  def show
    @checkin = Checkin.find(params[:id])
  end
end
