class MainController < ApplicationController
	include ApplicationHelper
	skip_before_action :auth_user

	def welcome
		@news = News.new
		#if flash.empty?
		unless session[:welcome_msg]
			flash_message('notice', t('flash_messages.welcome'))
			session[:welcome_msg] = true
		end
		render 'public/welcome'
	end

	def terms
		render 'public/terms'
	end

	def redirect_to_back
		if back_params[:kind] == 'model' || back_params[:kind] == 'accessory'
			redirect_to shop_products_path(back_params)
		elsif back_params[:kind] == 'fabric'
			redirect_to shop_fabrics_path(back_params)
		else
			redirect_to root_path
		end
		#redirect_back(fallback_location: root_path)
	end

	private

    def back_params
    	params.permit(:kind, :customer, :family) #params used in filter
    end

end
