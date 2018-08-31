class RadiobuttonOptionsController < ApplicationController
  before_action :set_survey
  before_action :set_radiobutton, except: %i[update destroy]
  before_action :set_radiobutton_option, except: %i[new create]

  def new
    @radiobutton_option = @radiobutton.radiobutton_options.new
  end

  def create
    @radiobutton_option = RadiobuttonOption.create(option_params.merge(radiobutton_id: @radiobutton.id))
    redirect_to survey_path(@survey)
  end

  def edit; end

  def update
    @radiobutton_option.update(option_params)
    redirect_to survey_path(@survey), notice: 'Optionname was successfully updated.'
  end

  def destroy
    @radiobutton_option.destroy
    redirect_to survey_path(@survey), notice: 'Option was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_radiobutton
    @radiobutton = Radiobutton.find(params[:radiobutton_id])
  end

  def set_radiobutton_option
    @radiobutton_option = RadiobuttonOption.find(params[:id])
  end

  def option_params
    params.require(:radiobutton_option).permit(:optionname)
  end
end
