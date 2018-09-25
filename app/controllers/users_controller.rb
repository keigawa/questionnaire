class UsersController < ApplicationUsersController
  before_action :set_company, only: %i[index create new]
  before_action :redirect

  def index
    @users = User.where(company_id: current_user.company_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :name, :image, :image_cache, :remove_image, :password).merge(president: false, company_id: current_user.company_id))
    if @user.save
      redirect_to company_users_path
    else
      render action: :new
  end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to company_users_path
  end

  private

  def set_company
    @company = Company.find(current_user.company_id)
  end

  def redirect
    unless current_user.president
      redirect_to home_user_path
      nil
    end
end
end
