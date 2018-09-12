# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    @survey = Survey.find(params[:survey_id])
    done_flag = UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id)
    redirect_to surveys_path if done_flag
    questions = Question.where(survey_id: params[:survey_id]).order(:display_order)
    @n = 1
    questions.each do |q|
      if Answer.find_by(question_id: q.id, user_id: current_user.id)
      else
        @textbox = Textbox.find_by(question_id: q.id)
        @textarea = Textarea.find_by(question_id: q.id)
        @checkbox = Checkbox.find_by(question_id: q.id)
        if @checkbox
          @checkbox_options = CheckboxOption.where(checkbox_id: @checkbox.id)
        end
        @radiobutton = Radiobutton.find_by(question_id: q.id)
        if @radiobutton
          @radiobutton_options = RadiobuttonOption.where(radiobutton_id: @radiobutton.id)
        end
        @question = q
        break
      end
      @n += 1
    end
    redirect_to verify_path(id: @survey.id) if @n > questions.count
    if @textbox
      @answer_textbox = AnswerTextbox.new
    elsif @textarea
      @answer_textarea = AnswerTextarea.new
    elsif @checkbox
      @answer_checkbox_option = AnswerCheckboxOption.new
    elsif @radiobutton
      @answer_radiobutton_option = AnswerRadiobuttonOption.new
    end
  end
end
