class VerifiesController < ApplicationController
  def display
    @survey=Survey.find(params[:id])
    @questions=Question.where(survey_id: params[:id]).order(:display_order)
    @n=1
  end
end
