# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  rescue_from NoMethodError, with: :no_method_error

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def change_locale
    session[:locale] = params[:locale] if params[:locale].present?
    redirect_back fallback_location: root_path
  end

  private

  def no_method_error
    redirect_to root_path
  end
end
