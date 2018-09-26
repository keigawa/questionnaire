class QuestionsController < ApplicationAdminsController
  def index
    @survey = Survey.find(params[:survey_id])
    @questions = Question.where(survey_id: params[:survey_id]).order(:display_order)
    @n = 1
    @company = Company.find(@survey.company_id)
  end

  def new
    @survey = Survey.find(params[:survey_id])
  end
end
