# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
  if current_user
    surveys_path
  elsif current_admin
    companies_path
  end
end

def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name company_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name company_id])
  end

  end
