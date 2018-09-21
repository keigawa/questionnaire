class AnswerCheckboxOptionsController < ApplicationUsersController
  def create
    @survey = Survey.find(params[:survey_id])
    checkbox = Checkbox.find_by(question_id: params[:question_id])
    options = CheckboxOption.where(checkbox_id: checkbox.id)
    options.each do |op|
      answer = Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
      answer_option = AnswerCheckboxOption.create(check: 'no', answer_id: answer.id, checkbox_option_id: op.id)
      if params[:answer_array].include?(op.id.to_s)
        answer_option.update(check: 'yes')
      end
    end
    redirect_to new_survey_answer_path(@survey)
  end
end
