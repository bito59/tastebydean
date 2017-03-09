module Shop
	class WorkshopController < ApplicationController
		include ApplicationHelper

		skip_before_action :auth_user, only: [:show]

		def show
			define_area
			respond_to do |format|
				format.html { render 'shop/workshop.html.haml' }
			end
		end
	end
end
