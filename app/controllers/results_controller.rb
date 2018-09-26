class ResultsController < ApplicationUsersController
  def index
    @survey = Survey.find(params[:id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    unless current_user.president
      redirect_to home_user_path unless done_flag
    end
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
  end
end
