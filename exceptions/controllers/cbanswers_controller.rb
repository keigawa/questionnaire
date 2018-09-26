class CbanswersController < ApplicationUsersController
  before_action :set_checkbox

  def edit
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @checkbox_options = CheckboxOption.where(checkbox_id: params[:id])
   end

  def update
    question = Question.find(@checkbox.question_id)
    answers = Answer.where(question_id: question.id).where(user_id: current_user.id)
    answers.each do |a|
      answer_option = AnswerCheckboxOption.find_by(answer_id: a.id)
      answer_option.update_attribute(:check, 'no')
      next unless params[:answer_array]
      if params[:answer_array].include?(answer_option.checkbox_option_id.to_s)
        answer_option.update_attribute(:check, 'yes')
      end
    end
    redirect_to verify_path(id: params[:survey_id])
  end

  def destroy
    question = Question.find(@checkbox.question_id)
    answers = Answer.where(question_id: question.id).where(user_id: current_user.id)
    answers.each do |a|
      AnswerCheckboxOption.find_by(answer_id: a.id).destroy
    end
    answers.destroy_all
    redirect_to verify_path(id: params[:survey_id])
  end

  private

  def set_checkbox
    @checkbox = Checkbox.find(params[:id])
  end
end
