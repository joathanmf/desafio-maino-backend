class UploadsController < ApplicationController
  def index; end

  def create
    redirect_to uploads_path, alert: I18n.t('notices.alert.no_file') and return if params[:file].nil?

    UploadService.new(params[:file], current_user.id).call

    redirect_to uploads_path, notice: I18n.t('notices.success.upload')
  rescue ArgumentError => e
    redirect_to uploads_path, alert: e.message
  end
end
