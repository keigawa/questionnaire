class AnswerCheckboxOptionsController < ApplicationController
 def create
    @survey=Survey.find(params[:survey_id])
    checkbox=Checkbox.find_by(question_id: params[:question_id])
    params[:answer_array].each do |a|
    answer=Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
    AnswerCheckboxOption.create(check: "yes", answer_id: answer.id, checkbox_option_id: a)
    end
    options=CheckboxOption.where(checkbox_id: checkbox.id)
    options.each do |op|
      if AnswerCheckboxOption.find_by(checkbox_option_id: op.id)
      else
    answer=Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
        AnswerCheckboxOption.create(check: "no", answer_id: answer.id, checkbox_option_id: op.id)
      end
end
   redirect_to new_survey_answer_path(@survey)
 end

 end
