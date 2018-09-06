class AnswerTextareasController < ApplicationController
  def create
    @survey=Survey.find(params[:survey_id])
    @answer=Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
    AnswerTextarea.create(params.require(:answer_textarea).permit(:content, :textarea_id).merge(answer_id: @answer.id))
    redirect_to new_survey_answer_path(@survey)
  end
end
