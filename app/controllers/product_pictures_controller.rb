class ProductPicturesController < ApplicationController
  before_action :set_picture, only: [:show, :update]

  def create
    @picture = ProductPicture.new(pictures_params)
    if @picture.save
        format.json render status: 200, json: {
          success: "Successfully created the picture"
        }.to_json
    else
        format.json render status: 200, json: {
          success: "Failed to create the picture"
        }.to_json
    end
  end

  def update
    respond_to do |format|
      if @picture.update_attributes(pictures_params)
        format.json render status: 200, json: {
          success: "Successfully updated the picture"
        }.to_json
    else
        format.json render status: 200, json: {
          success: "Failed to update the picture"
        }.to_json
      end
    end
  end

  def destroy
    respond_to do |format|
      if @picture.destroy
        format.json render status: 200, json: {
          success: "Successfully destroyed the picture"
        }.to_json
    else
        format.json render status: 200, json: {
          success: "Failed to destroy the picture"
        }.to_json
      end
    end
  end

  private

  def set_picture
    @picture = ProductPicture.find(params[:id])
  end

  def pictures_params
    params.require(:product_picture).permit(:product_id, :serial, :activated, :main, {image:[]})
  end
end