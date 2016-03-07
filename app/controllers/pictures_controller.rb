class PicturesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_picture, only: [:destroy]

  #respond_to :js

  def create
    params[:images].each do |image|
      @picture = Picture.create(image: image, gallery_id: params[:picture][:gallery_id])
    end
    #@picture = Picture.create(picture_params)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'create.js.erb' }
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render 'destroy.js.erb' }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:images, :gallery_id)
    end
end
