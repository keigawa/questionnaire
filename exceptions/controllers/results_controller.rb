class ResultsController < ApplicationUsersController
  def index
    @survey = Survey.find(params[:id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    if done_flag
    else redirect_to home_user_path
    end
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
  end
end
