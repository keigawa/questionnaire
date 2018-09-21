class RadiobuttonsController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_radiobutton, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @radiobutton = Radiobutton.new
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
    Radiobutton.create(radiobutton_params.merge(question_id: question.id))
    redirect_to survey_path(@survey)
  end

  def edit; end

  def update
    @radiobutton.update(radiobutton_params)
    redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
  end

  def destroy
    options = RadiobuttonOption.where(radiobutton_id: @radiobutton.id)
    options.delete_all
    question = Question.find_by(id: @radiobutton.question_id)
    @radiobutton.destroy
    question.destroy
    redirect_to survey_path(@survey), notice: 'Question was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_radiobutton
    @radiobutton = Radiobutton.find(params[:id])
  end

  def radiobutton_params
    params.require(:radiobutton).permit(:subject)
  end
end
