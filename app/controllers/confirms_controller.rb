class ConfirmsController < ApplicationAdminsController
  def set_flag
    @survey = Survey.find(params[:id])
    questions = Question.where(survey_id: params[:id])
    if questions.empty?
      redirect_to survey_path(@survey), alert: 'Question has not been created.'
      return
    end
    checkboxes = []
    radiobuttons = []
    questions.each do |q|
      if checkbox = Checkbox.find_by(question_id: q.id)
        checkboxes.push(checkbox)
    end
      if radiobutton = Radiobutton.find_by(question_id: q.id)
        radiobuttons.push(radiobutton)
    end
    end
    if checkboxes.empty?
    else checkboxes.each do |cb|
      if CheckboxOption.where(checkbox_id: cb.id).empty?
        redirect_to survey_path(@survey), alert: 'There are questions not having checkboxes.'
        return
      end
    end
  end
    if radiobuttons.empty?
    else radiobuttons.each do |rb|
      if RadiobuttonOption.where(radiobutton_id: rb.id).empty?
        redirect_to survey_path(@survey), alert: 'There are questions not having radiobuttons.'
        return
      end
    end
  end
    @survey.update_attribute(:complete_flag, 'true')
    redirect_to surveys_path(company_id: @survey.company_id), notice: 'Survey completed.'
end
end
