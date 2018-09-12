class VerifiesController < ApplicationController
  before_action :set_survey
  def display
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
  end

  def done_flag
    UserSurvey.create(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
