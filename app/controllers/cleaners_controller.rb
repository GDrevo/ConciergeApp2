class CleanersController < ApplicationController
  def show
    @cleaner = Cleaner.find(params[:id])
    respond_to do |format|
      format.json { render json: @cleaner, status: :ok }
    end
  end
end
