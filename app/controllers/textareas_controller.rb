class TextareasController < ApplicationController
  before_action :set_survey
  before_action :set_textarea, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @textarea = Textarea.new
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
    Textarea.create(textarea_params.merge(question_id: question.id))
    redirect_to survey_path(@survey)
  end

  def edit; end

  def update
    @textarea.update(textarea_params)
    redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
  end

  def destroy
    question = Question.find_by(id: @textarea.question_id)
    @textarea.destroy
    question.destroy
    redirect_to survey_path(@survey), notice: 'Question was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_textarea
    @textarea = Textarea.find(params[:id])
  end

  def textarea_params
    params.require(:textarea).permit(:subject)
  end
end
