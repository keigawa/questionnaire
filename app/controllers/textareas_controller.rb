class TextareasController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_textarea, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @textarea = Textarea.new
  end

  def create
    questions = Question.where(survey_id: params[:survey_id])
    latest_number = if questions.empty?
                      0
                    else
                      questions.maximum(:display_order)
                   end
    question = Question.create(display_order: latest_number + 1, survey_id: params[:survey_id])
    @textarea = Textarea.new(textarea_params.merge(question_id: question.id))
    if @textarea.save
      redirect_to survey_path(@survey)
    else
      question.destroy
      render action: :new
    end
  end

  def edit; end

  def update
    if @textarea.update(textarea_params)
      redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
    else
      render action: :edit
  end
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
