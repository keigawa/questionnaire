class RadiobuttonsController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_radiobutton, only: %i[edit update destroy]

  def new
    @question = @survey.questions.new
    @radiobutton = Radiobutton.new
  end

  def create
    questions = Question.where(survey_id: params[:survey_id])
    latest_number = if questions.empty?
                      0
                    else
                      questions.maximum(:display_order)
                    end
    question = Question.create(display_order: latest_number + 1, survey_id: params[:survey_id])
    @radiobutton = Radiobutton.new(radiobutton_params.merge(question_id: question.id))
    if @radiobutton.save
      redirect_to survey_path(@survey)
    else
      question.destroy
      render action: :new
    end
  end

  def edit; end

  def update
    if @radiobutton.update(radiobutton_params)
      redirect_to survey_path(@survey), notice: 'Question was successfully updated.'
    else
      render action: :edit
  end
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
