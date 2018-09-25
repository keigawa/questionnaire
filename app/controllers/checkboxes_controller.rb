class CheckboxesController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_checkbox, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @checkbox = Checkbox.new
  end

  def create
    questions = Question.where(survey_id: params[:survey_id])
    latest_number = if questions.empty?
                      0
                    else
                      questions.maximum(:display_order)
                    end
    question = Question.create(display_order: latest_number + 1, survey_id: params[:survey_id])
    @checkbox = Checkbox.new(checkbox_params.merge(question_id: question.id))
    if @checkbox.save
      redirect_to survey_path(@survey)
    else
      question.destroy
      render action: :new
    end
  end

  def edit; end

  def update
    if @checkbox.update(checkbox_params)
      redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
    else
      render action: :edit
  end
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
