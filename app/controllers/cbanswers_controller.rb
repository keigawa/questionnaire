class CbanswersController < ApplicationController
  before_action :set_checkbox

  def edit
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @checkbox_options = CheckboxOption.where(checkbox_id: params[:id])
   end

  def update
    AnswerCheckboxOption.update(check: 'no')
    params[:answer_array].each do |a|
      checked_op = AnswerCheckboxOption.find_by(checkbox_option_id: a)
      checked_op.update(check: 'yes')
    end
    redirect_to verify_path(id: params[:survey_id])
  end

  private

  def set_checkbox
    @checkbox = Checkbox.find(params[:id])
  end
end
