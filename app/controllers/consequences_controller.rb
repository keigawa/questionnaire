class ConsequencesController < ApplicationUsersController
  def display
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    if done_flag
    else redirect_to surveys_path
    end
    answers = Answer.where(question_id: params[:question_id])
    checkbox = Checkbox.find_by(question_id: params[:question_id])
    radiobutton = Radiobutton.find_by(question_id: params[:question_id])
    @answers = []
    @answer_options = {}
    if Textbox.find_by(question_id: params[:question_id])
      answers.each do |answer|
        answer_textbox = AnswerTextbox.find_by(answer_id: answer.id)
        if UserSurvey.find_by(user_id: answer.user_id, survey_id: @survey.id)
          @answers.push(answer_textbox)
        end
      end
    elsif Textarea.find_by(question_id: params[:question_id])
      answers.each do |answer|
        answer_textarea = AnswerTextarea.find_by(answer_id: answer.id)
        if UserSurvey.find_by(user_id: answer.user_id, survey_id: @survey.id)
          @answers.push(answer_textarea)
        end
      end
    elsif checkbox
      checkbox_options = CheckboxOption.where(checkbox_id: checkbox.id)
      checkbox_options.each do |op|
        checked_options = AnswerCheckboxOption.where(check: 'yes').where(checkbox_option_id: op.id)
        answer_array = []
        checked_options.each do |c|
          answer = Answer.find(c.answer_id)
          if UserSurvey.find_by(user_id: answer.user_id, survey_id: @survey.id)
            answer_array.push(c)
          end
        end
        checked_option_number = answer_array.count
        @answer_options.merge!(op.optionname => checked_option_number)
      end
    elsif radiobutton
      radiobutton_options = RadiobuttonOption.where(radiobutton_id: radiobutton.id)
      radiobutton_options.each do |op|
        checked_options = AnswerRadiobuttonOption.where(check: 'yes').where(radiobutton_option_id: op.id)
        answer_array = []
        checked_options.each do |c|
          answer = Answer.find(c.answer_id)
          if UserSurvey.find_by(user_id: answer.user_id, survey_id: @survey.id)
            answer_array.push(c)
          end
        end
        checked_option_number = answer_array.count
        @answer_options.merge!(op.optionname => checked_option_number)
      end
    end
  end
end
