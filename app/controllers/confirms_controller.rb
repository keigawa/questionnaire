class ConfirmsController < ApplicationController
  def set_flag
    @survey=Survey.find(params[:id])
    questions=@survey.questions
    # Question.where(survey_id: params[:id])
    if questions.empty?
      redirect_to survey_path(@survey)
    end
    checkboxes_include_nil=[]
    radiobuttons_include_nil=[]
    questions.each do |q|
      checkboxes_include_nil.push(Checkbox.find_by(question_id: q.id))
      radiobuttons_include_nil.push(Radiobutton.find_by(question_id: q.id))
    end
    checkboxes=checkboxes_include_nil.compact
    radiobuttons=radiobuttons_include_nil.compact
    if checkboxes.empty?
    else checkboxes.each do |cb|
      if CheckboxOption.where(checkbox_id: cb.id).empty?
        redirect_to survey_path(@survey)
        exit
      end
    end
    end
    if radiobuttons.empty?
    else radiobuttons.each do |rb|
      if RadiobuttonOption.where(radiobutton_id: rb.id).empty?
        redirect_to survey_path(@survey)
        exit
      end
    end
    end
    @survey.update_attribute(:complete_flag, 'true')
    redirect_to surveys_path(@survey)
  end
end
