class RbanswersController < ApplicationUsersController
  before_action :set_radiobutton

  def edit
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @radiobutton_options = RadiobuttonOption.where(radiobutton_id: params[:id])
   end

  def update
    question = Question.find(@radiobutton.question_id)
    answers = Answer.where(question_id: question.id, user_id: current_user.id)
    answers.each do |a|
      answer_option = AnswerRadiobuttonOption.find_by(answer_id: a.id)
      answer_option.update_attribute(:check, 'no')
      if params[:answer_button] == answer_option.radiobutton_option_id.to_s
        answer_option.update_attribute(:check, 'yes')
      end
    end
    redirect_to verify_path(id: params[:survey_id])
  end

  def destroy
    question = Question.find(@radiobutton.question_id)
    answers = Answer.where(question_id: question.id).where(user_id: current_user.id)
    answers.each do |a|
      AnswerRadiobuttonOption.find_by(answer_id: a.id).destroy
    end
    answers.destroy_all
    redirect_to verify_path(id: params[:survey_id])
    end

  private

  def set_radiobutton
    @radiobutton = Radiobutton.find(params[:id])
  end
end
