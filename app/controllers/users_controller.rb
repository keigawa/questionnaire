class UsersController < ApplicationUsersController
  before_action :set_company, only: %i[index new]
  def index
    @users = User.where(company_id: current_user.company_id)
  end

  def new
    @user = User.new
  end

  def create
    if User.find_by(email: params[:email])
    else
      User.create(params.require(:user).permit(:email, :name, :password).merge(president: false, company_id: current_user.company_id))
    end
    redirect_to company_users_path
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to company_users_path
  end

  private

  def set_company
    @company = Company.find(current_user.company_id)
  end
end
