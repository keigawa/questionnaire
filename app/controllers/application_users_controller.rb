class ApplicationUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :logout

  layout 'layouts/user'

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  private

  def logout
    @user_signed_in = user_signed_in?
  end
end
