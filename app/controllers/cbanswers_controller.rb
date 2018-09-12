class CbanswersController < ApplicationController
  before_action :set_checkbox

def edit
   @survey=Survey.find(params[:survey_id])
    done_flag=UserSurvey.find_by(user_id: current_user.id, survey_id: @survey.id) 
    if done_flag
    redirect_to surveys_path
    end
   @checkbox_options=CheckboxOption.where(checkbox_id: params[:id])
 end

 def update
    AnswerCheckboxOption.update(check: "no")
    params[:answer_array].each do |a|
    checked_op=AnswerCheckboxOption.find_by(checkbox_option_id: a)
    checked_op.update_attributes(check: "yes")
    end
    redirect_to verify_path(:id => params[:survey_id])
 end 

 private
 def set_checkbox
   @checkbox=Checkbox.find(params[:id])
 end
   

end
