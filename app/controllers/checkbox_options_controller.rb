class CheckboxOptionsController < ApplicationAdminsController
  before_action :set_survey
  before_action :set_checkbox, except: :destroy
  before_action :set_checkbox_option, except: %i[new create]

  def new
    @checkbox_option = @checkbox.checkbox_options.new
  end

  def create
    @checkbox_option = CheckboxOption.new(option_params.merge(checkbox_id: @checkbox.id))
    if @checkbox_option.save
      redirect_to survey_path(@survey)
    else
      render action: :new
  end
  end

  def edit; end

  def update
    if @checkbox_option.update(option_params)
      redirect_to survey_path(@survey), notice: 'Optionname was successfully updated.'
    else
      render action: :edit
  end
  end

  def destroy
    @checkbox_option.destroy
    redirect_to survey_path(@survey), notice: 'Option was successfully deleted.'
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_checkbox
    @checkbox = Checkbox.find(params[:checkbox_id])
  end

  def set_checkbox_option
    @checkbox_option = CheckboxOption.find(params[:id])
  end

  def option_params
    params.require(:checkbox_option).permit(:optionname)
  end
end
