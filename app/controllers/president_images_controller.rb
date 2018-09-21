class PresidentImagesController < ApplicationController
  before_action :set_company
  before_action :set_president, only: %i[create update destroy]

  def new; end

  def edit; end

  def update
    @president.update_attribute(:image, params.permit(:image, :image_cache, :remove_image))
    redirect_to company_path(@company)
  end

  def destroy
    @president.update_attribute(:image, nil)
    redirect_to company_path(@company)
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_president
    @president = User.find_by(president: true, company_id: @company.id)
  end
end
