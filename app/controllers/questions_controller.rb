class QuestionsController < ApplicationController
  before_action :set_survey

  def new
  @question=@survey.questions.new
  end

  def create
   @question=@survey.questions.create(question_params)
   #p params[:type]
   type=params[:type]
    if type=="textbox"
    redirect_to new_survey_question_textbox_path(@survey,@question)
  elsif type=="textarea" 
    redirect_to new_survey_question_textarea_path(@survey,@question)
  elsif type=="checkbox"
redirect_to new_survey_question_checkbox_path(@survey,@question)
  elsif type=="radiobutton"
redirect_to new_survey_question_radiobutton_path(@survey,@question)
  end
  end

private
def set_survey
  @survey=Survey.find(params[:survey_id])
end

def question_params
    params.permit(:number,:survey_id)
  end
end


