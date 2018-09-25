class DeleteAllsController < ApplicationAdminsController
  def destroy
    survey = Survey.find(params[:id])
    company = Company.find(survey.company_id)
    questions = Question.where(survey_id: survey.id)
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
    UserSurvey.where(survey_id: survey.id).destroy_all
    survey.destroy
    redirect_to surveys_path(company_id: company.id)
  end
end
