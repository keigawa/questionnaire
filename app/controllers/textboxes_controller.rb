class TextboxesController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_textbox, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @textbox = Textbox.new
  end

  def create
    questions = Question.where(survey_id: params[:survey_id])
    latest_number = if questions.empty?
                      0
                    else
                      questions.maximum(:display_order)
                    end
    question = Question.create(display_order: latest_number + 1, survey_id: params[:survey_id])
    @textbox = Textbox.new(textbox_params.merge(question_id: question.id))
    if @textbox.save
      redirect_to survey_path(@survey)
    else
      question.destroy
      render action: :new
    end
  end

  def edit; end

  def update
    if @textbox.update(textbox_params)
      redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
    else
      render action: :edit
  end
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
