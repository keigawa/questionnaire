class SurveysController < ApplicationController
  before_action :set_survey, only: %i[show edit destroy]

  def index
    @done_flag = if UserSurvey.find_by(user_id: current_user.id)
                   true
                 else
                   false
               end
    @surveys = Survey.where(company_id: current_user.company_id)
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.create(survey_params.merge(company_id: current_user.company_id))
    redirect_to survey_path(@survey)
  end

  def show
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
  end

  def edit; end

  def update
    @survey.update(survey_params)
    redirect_to survey_path(@survey), notice: 'Survey was successfully updated.'
  end

  def destroy
    @questions = Question.where!(survey_id: @survey.id)
    @questions.each do |q|
      @textbox = Textbox.find_by!(question_id: q.id)
      @textbox.destroy
      @textarea = Textarea.find_by!(question_id: q.id)
      @textarea.destroy
      @checkboxes = []
      @checkbox = Checkbox.find_by!(question_id: q.id)
      @checkboxes.push(@checkbox)
      @checkboxes.each do |cb|
        @checkbox_option = CheckboxOption.destroy_all(checkbox_id: cb.id)
      end
      @checkbox
      @radiobutton = []
      @radiobutton = Radiobutton.find_by!(question_id: q.id)
      @radiobutton.push(@radiobutton)
      @radiobuttons.each do |rb|
        @radiobutton_option = RudiobuttonOption.destroy_all(radiobutton_id: rb.id)
      end
    end
    @survey.destroy
    redirect_to surveys_path, notice: 'Survey was successfully destroyed.'
  end

  def confirm; end

  def result; end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title)
    end
end
