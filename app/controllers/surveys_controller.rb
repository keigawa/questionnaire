class SurveysController < ApplicationController
  def index
    if UserSurvey.find_by(user_id: current_user.id)
    @done_flag=true
  else
    @done_flag=false
  end
    @surveys=Survey.where(company_id: current_user.company_id)
  end

  def new 
    @survey=Survey.new
  end

  def create
    @survey.create(survey_params.merge(company_id: current_user.company_id))
    redirect_to new_survey_question_path(@survey)
  end

private
def survey_params
    params.require(:survey).permit(:title)
  end
end

