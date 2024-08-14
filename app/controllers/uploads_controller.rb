class UploadsController < ApplicationController
  def index; end

  def create
    redirect_to uploads_path and return if params[:file].nil?

    UploadService.new(params[:file]).call

    redirect_to uploads_path
  end
end
