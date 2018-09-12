class AnswerTextareasController < ApplicationController
  before_action :set_survey
  before_action :set_answer_textarea, only: %i[edit update]

  def create
    @answer = Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
    AnswerTextarea.create(params.require(:answer_textarea).permit(:content, :textarea_id).merge(answer_id: @answer.id))
    redirect_to new_survey_answer_path(@survey)
  end

  def edit
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @textarea = Textarea.find(@answer_textarea.textarea_id)
  end

  def update
    @answer_textarea.update(params.require(:answer_textarea).permit(:content))
    redirect_to verify_path(id: @survey.id)
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_answer_textarea
    @answer_textarea = AnswerTextarea.find(params[:id])
  end
end
