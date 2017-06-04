class FabricsController < ApplicationController
	before_action :set_fabric, only: [:show, :update, :destroy]
	#before_action :remove_old_picture, only: [:update]

	def create
		@fabric = Fabric.new(fabric_params)
		if @fabric.save
		    format.json render status: 200, json: {
		      success: "Successfully created fabric"
		    }.to_json
		else
		    format.json render status: 400, json: {
		      success: "Failed to create fabric"
		    }.to_json
		end
	end

	def update
		respond_to do |format|
			#remove_old_picture
			if @fabric.update_attributes(fabric_params)
				format.json render status: 200, json: {
				  success: "Successfully updated fabric"
				}.to_json
			else
				format.json render status: 400, json: {
				  success: "Failed to update fabric"
				}.to_json
			end
		end
	end

	def destroy
		respond_to do |format|
		  if @fabric.destroy
		    format.json render status: 200, json: {
		      success: "Successfully destroy fabric"
		    }.to_json
		else
		    format.json render status: 400, json: {
		      success: "Failed to destroy fabric"
		    }.to_json
		  end
		end
	end

	private

	def set_fabric
		@fabric = Fabric.friendly.find(params[:id])
	end

	def fabric_params
		params.require(:fabric).permit(
			:activated, :kind, :title, 
			:description, :price, :price_unit
		)
	end
end
