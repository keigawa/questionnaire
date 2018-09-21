class ImagesController < ApplicationController
  def edit; end

  def update
    current_user.update_attribute(:image, params.permit(:image, :image_cache, :remove_image))
    redirect_to profile_path
  end
end
