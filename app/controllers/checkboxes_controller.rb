class CheckboxesController < ApplicationController
  before_action :set_survey
  before_action :set_checkbox, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @checkbox = Checkbox.new
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
    Checkbox.create(checkbox_params.merge(question_id: question.id))
    redirect_to survey_path(@survey)
  end

  def edit; end

  def update
    @checkbox.update(checkbox_params)
    redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
  end

  def destroy
    options = CheckboxOption.where(checkbox_id: @checkbox.id)
    options.delete_all
    question = Question.find_by(id: @checkbox.question_id)
    @checkbox.destroy
    question.destroy
    redirect_to survey_path(@survey), notice: 'Question was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_checkbox
    @checkbox = Checkbox.find(params[:id])
  end

  def checkbox_params
    params.require(:checkbox).permit(:subject)
  end
end
