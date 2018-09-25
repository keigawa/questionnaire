class AnswerRadiobuttonOptionsController < ApplicationUsersController
  def create
    @survey = Survey.find(params[:survey_id])
    radiobutton = Radiobutton.find_by(question_id: params[:question_id])
    options = RadiobuttonOption.where(radiobutton_id: radiobutton.id)
    options.each do |op|
      answer = Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
      answer_option = AnswerRadiobuttonOption.create(check: 'no', answer_id: answer.id, radiobutton_option_id: op.id)
      answer_option.update(check: 'yes') if op.id.to_s == params[:answer_button]
    end
    redirect_to new_survey_answer_path(@survey)
  end
end
