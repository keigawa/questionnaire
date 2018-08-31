# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    @survey=Survey.find(params[:survey_id])
    questions=Question.where(survey_id: params[:survey_id]).order(:display_order)
    question_first=questions.first
      if Answer.find_by(question_id: question_first.id, user_id: current_user.id)
            #answered_last=Answer.where(user_id: current_user.id, survey_id: params[:survey_id]).last
      #question_answered_last=Question.find(answerd_last.id)
      @n=1
      #Answer.where(user_id: current_user.id, survey_id: params[:survey_id])
      questions.each do |q|
        if Answer.find_by(question_id: q.id, user_id: current_user.id)
        else
         # @question=q
        @textbox=Textbox.find_by(question_id: q.id)
        @textarea=Textarea.find_by(question_id: q.id)
        @chechbox=Checkbox.find_by(question_id: q.id)
        if @checkbox
        @checkbox_options=CheckboxOption.where(checkbox_id: @checkbox.id)
        end
        @radiobutton=Radiobutton.find_by(question_id: q.id)
        if @radiobutton
        @radiobutton_options=RadiobuttonOption.where(radiobutton_id: @radiobutton.id)
        end
        @answer_textbox=AnswerTextbox.new
        @answer_textarea=AnswerTextarea.new
        @answer_checkbox_option=AnswerCheckboxOption.new
        @answer_radiobutton_option=AnswerRadiobuttonOption.new
        end
        @n+=1
      end
  else
        #@question=question_first
        @textbox=Textbox.find_by!(question_id: question_first.id)
        @textarea=Textarea.find_by(question_id: question_first.id)
        @chechbox=Checkbox.find_by(question_id: question_first.id)
        if @checkbox
        @checkbox_options=CheckboxOption.where(checkbox_id: @checkbox.id)
        end
        @radiobutton=Radiobutton.find_by(question_id: question_first.id)
        if @radiobutton
        @radiobutton_options=RadiobuttonOption.where(radiobutton_id: @radiobutton.id)
        end
        @answer_textbox=AnswerTextbox.new
        @answer_textarea=AnswerTextarea.new
        @answer_checkbox_option=AnswerCheckboxOption.new
        @answer_radiobutton_option=AnswerRadiobuttonOption.new
        @n=1
      end

  end
end
