# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def set_locale
    I18n.locale = session[:locale]&.to_sym || I18n.default_locale
  end

  def change_locale
    session[:locale] = params[:locale] if params[:locale].present?
    redirect_back fallback_location: root_path
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('notices.alert.access_denied')
    redirect_to request.referer || root_path
  end

  def record_not_found
    flash[:alert] = I18n.t('notices.alert.record_not_found')
    redirect_to request.referer || root_path
  end
end
