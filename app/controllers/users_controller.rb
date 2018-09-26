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
    user = User.find(params[:id])
    answers = Answer.where(user_id: user.id)
    answers.each do |a|
      if textbox = AnswerTextbox.find_by(answer_id: a.id)
        textbox.destroy
      elsif textarea = AnswerTextarea.find_by(answer_id: a.id)
        textarea.destroy
      elsif checkbox_option = AnswerCheckboxOption.find_by(answer_id: a.id)
        checkbox_option.destroy
      elsif radiobutton_option = AnswerRadiobuttonOption.find_by(answer_id: a.id)
        radiobutton_option.destroy
      end
    end
    answers.destroy_all
    user.destroy
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
