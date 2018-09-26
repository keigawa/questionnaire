class SurveysController < ApplicationAdminsController
  before_action :set_survey, only: %i[show edit update destroy]
  before_action :set_company, only: %i[index new edit]

  def index
    @surveys = Survey.where(company_id: params[:company_id])
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to surveys_path(company_id: @survey.company_id)
    else
      @company = Company.find(@survey.company_id)
      render action: :new
  end
  end

  def show
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
    @company = Company.find(@survey.company_id)
  end

  def edit; end

  def update
    if @survey.update(survey_params)
      redirect_to survey_path(@survey), notice: 'Survey was successfully updated.'
    else
      @company = Company.find(@survey.company_id)
      render action: :edit
  end
  end

  def destroy
    company = Company.find(@survey.company_id)
    questions = Question.where(survey_id: @survey.id)
    checkboxes = []
    radiobuttons = []
    questions.each do |q|
      textbox = Textbox.find_by!(question_id: q.id)
      textbox.destroy
      textarea = Textarea.find_by!(question_id: q.id)
      textarea.destroy
      checkbox = Checkbox.find_by!(question_id: q.id)
      checkboxes.push(checkbox)
      checkboxes.each do |cb|
        CheckboxOption.destroy_all(checkbox_id: cb.id)
      end
      checkbox.destroy
      radiobutton = Radiobutton.find_by!(question_id: q.id)
      radiobuttons.push(radiobutton)
      radiobuttons.each do |rb|
        RudiobuttonOption.destroy_all(radiobutton_id: rb.id)
      end
      radiobutton.destroy
    end
    if questions.empty?
    else
      questions.destroy_all
    end
    @survey.destroy
    redirect_to surveys_path(company_id: company.id), notice: 'Survey was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title, :company_id)
  end
end
