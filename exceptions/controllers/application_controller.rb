# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    if current_user
      home_user_path
    elsif current_admin
      companies_path
    end
  end

  unless Rails.env.development?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :render_404
    rescue_from ActionController::RoutingError,   with: :render_404
end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.xhr?
      render json: { error: '404 error' }, status: 404
    else
      render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
    end
  end

  def render_500(e = nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e

    if request.xhr?
      render json: { error: '500 error' }, status: 500
    else
      render file: Rails.root.join('public/500.html'), status: 500, layout: false, content_type: 'text/html'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name company_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name company_id image image_cache remove_image])
  end
  end
