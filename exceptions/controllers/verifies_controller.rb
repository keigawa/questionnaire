class VerifiesController < ApplicationUsersController
  before_action :set_survey, except: [:destroy]
  def display
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    @questions = Question.where(survey_id: params[:id]).order(:display_order)
    @n = 1
  end

  def done_flag
    UserSurvey.create(user_id: current_user.id, survey_id: @survey.id)
    redirect_to home_user_path
  end

  def destroy
    answers = Answer.where(user_id: current_user.id).where(survey_id: params[:survey_id])
    answers.each do |a|
      if textbox = AnswerTextbox.find_by(answer_id: a.id)
        textbox.destroy
      elsif textarea = AnswerTextarea.find_by(answer_id: a.id)
        textarea.destroy
      elsif checkbox_option = AnswerCheckboxOption.find_by(answer_id: a.id)
        checkbox_option.destroy
      elsif radiobutton_option = AnswerRadiobuttonOption.find_by(answer_id: a.id)
        radiobutton_option.destroy
      end
    end
    answers.destroy_all
    redirect_to home_user_path
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
