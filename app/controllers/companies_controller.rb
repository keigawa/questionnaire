class CompaniesController < ApplicationAdminsController
  before_action :set_company, only: %i[show edit update]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    Company.create(company_params)
    redirect_to companies_path
  end

  def show
    @any_member = User.find_by(company_id: @company.id)
    @president = User.find_by(president: true, company_id: @company.id)
  end

  def edit; end

  def update
    @company.update(survey_params)
    redirect_to company_path(@company)
  end

  def destroy
    company = Company.find(params[:id])
    surveys = Survey.where(company_id: company.id)
    surveys.each do |s|
      questions = Question.where(survey_id: s.id)
      questions.each do |q|
        answers = Answer.where(question_id: q.id)
        answers.each do |a|
          if answer_textbox = AnswerTextbox.find_by(answer_id: a.id)
            answer_textbox.destroy
          elsif answer_textarea = AnswerTextarea.find_by(answer_id: a.id)
            answer_textarea.destroy
          elsif answer_cb_option = AnswerCheckboxOption.find_by(answer_id: a.id)
            answer_cb_option.destroy
          elsif answer_rb_option = AnswerRadiobuttonOption.find_by(answer_id: a.id)
            answer_rb_option.destroy
          end
        end
        answers.destroy_all
        if textbox = Textbox.find_by(question_id: q.id)
          textbox.destroy
        elsif textarea = Textarea.find_by(question_id: q.id)
          textarea.destroy
        elsif checkbox = Checkbox.find_by(question_id: q.id)
          checkbox_options = CheckboxOption.where(checkbox_id: checkbox.id)
          checkbox_options.destroy_all
          checkbox.destroy
        elsif radiobutton = Radiobutton.find_by(question_id: q.id)
          radiobutton_options = RadiobuttonOption.where(radiobutton_id: radiobutton.id)
          radiobutton_options.destroy_all
          radiobutton.destroy
        end
      end
      questions.destroy_all
      UserSurvey.where(survey_id: s.id).destroy_all
    end
    surveys.destroy_all
    User.where(company_id: company.id).destroy_all
    company.destroy
    redirect_to companies_path
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
