class ApplicationAdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :logout

  layout 'layouts/admin'

  def after_sign_out_path_for(_resource)
    new_admin_session_path
  end

  private

  def logout
    @admin_signed_in = admin_signed_in?
  end
end
