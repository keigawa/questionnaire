class TextboxesController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_textbox, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @textbox = Textbox.new
  end

  def create
    exist_flag = Question.find_by(survey_id: params[:survey_id])
    if exist_flag
      latest_number = Question.where(survey_id: params[:survey_id]).maximum(:display_order)
      input_number = latest_number + 1
      question = Question.create(display_order: input_number, survey_id: params[:survey_id])
    else
      question = Question.create(display_order: 1, survey_id: params[:survey_id])
    end
    Textbox.create(textbox_params.merge(question_id: question.id))
    redirect_to survey_path(@survey)
  end

  def edit; end

  def update
    @textbox.update(textbox_params)
    redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
  end

  def destroy
    question = Question.find_by(id: @textbox.question_id)
    @textbox.destroy
    question.destroy
    redirect_to survey_path(@survey), notice: 'Question was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_textbox
    @textbox = Textbox.find(params[:id])
  end

  def textbox_params
    params.require(:textbox).permit(:subject)
  end
end
