class UploadsController < ApplicationController
  def index; end

  def create
    if params[:file].nil?
      flash[:alert] = 'Por favor, selecione um arquivo.'

      redirect_to uploads_path and return
    end

    UploadService.new(params[:file], current_user.id).call

    redirect_to uploads_path
  end
end
