# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :danger, :warning, :success, :info

  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, warning: t('pundit.error')
  end

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password,
        :password_confirmation, :remember_me, :first_name, :last_name)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password,
        :password_confirmation, :current_password, :first_name, :last_name)
    end
  end
end
