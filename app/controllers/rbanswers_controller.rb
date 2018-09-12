class RbanswersController < ApplicationController
  before_action :set_radiobutton

  def edit
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @radiobutton_options = RadiobuttonOption.where(radiobutton_id: params[:id])
   end

  def update
    AnswerRadiobuttonOption.update(check: 'no')
    pushed_button = AnswerRadiobuttonOption.find_by(radiobutton_option_id: params[:answer_button])
    pushed_button.update(check: 'yes')
    redirect_to verify_path(id: params[:survey_id])
  end

  private

  def set_radiobutton
    @radiobutton = Radiobutton.find(params[:id])
  end
end
