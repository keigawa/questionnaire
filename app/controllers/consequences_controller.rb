class ConsequencesController < ApplicationController
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
        @answers.push(answer_textbox)
      end
    elsif Textarea.find_by(question_id: params[:question_id])
      answers.each do |answer|
        answer_textarea = AnswerTextarea.find_by(answer_id: answer.id)
        @answers.push(answer_textarea)
      end
    elsif checkbox
      checkbox_options = CheckboxOption.where(checkbox_id: checkbox.id)
      checkbox_options.each do |op|
        checked_option_number = AnswerCheckboxOption.where(check: 'yes').where(checkbox_option_id: op.id).count
        @answer_options.merge!(op.optionname => checked_option_number)
      end
    elsif radiobutton
      radiobutton_options = RadiobuttonOption.where(radiobutton_id: radiobutton.id)
      radiobutton_options.each do |op|
        checked_option_number = AnswerRadiobuttonOption.where(check: 'yes').where(radiobutton_option_id: op.id).count
        @answer_options.merge!(op.optionname => checked_option_number)
      end
    end
  end
end
