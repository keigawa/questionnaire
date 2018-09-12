class AnswerRadiobuttonOptionsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    radiobutton = Radiobutton.find_by(question_id: params[:question_id])
    options = RadiobuttonOption.where(radiobutton_id: radiobutton.id)
    options.each do |op|
      answer = Answer.create(question_id: params[:question_id], user_id: current_user.id, survey_id: @survey.id)
      AnswerRadiobuttonOption.create(check: 'no', answer_id: answer.id, radiobutton_option_id: op.id)
    end
    pushed_button = AnswerRadiobuttonOption.find_by(radiobutton_option_id: params[:answer_button])
    pushed_button.update_attribute(:check, 'yes')
    redirect_to new_survey_answer_path(@survey)
  end
end
