class AnswerTextboxesController < ApplicationUsersController
  before_action :set_survey
  before_action :set_answer_textbox, only: %i[edit update]

  def create
    @answer = Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
    @answer_textbox = AnswerTextbox.new(params.require(:answer_textbox).permit(:content, :textbox_id).merge(answer_id: @answer.id))
    if @answer_textbox.save
      redirect_to new_survey_answer_path(@survey)
    else
      @answer.destroy
      render template: 'answers/new'
  end
  end

  def edit
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to home_user_path if done_flag
    @textbox = Textbox.find(@answer_textbox.textbox_id)
  end

  def update
    if @answer_textbox.update(params.require(:answer_textbox).permit(:content))
      redirect_to verify_path(id: @survey.id)
    else
      @textbox = Textbox.find(@answer_textbox.textbox_id)
      render action: :edit
  end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_answer_textbox
    @answer_textbox = AnswerTextbox.find(params[:id])
  end
end
