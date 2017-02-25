class MainController < ApplicationController
	include ApplicationHelper
	skip_before_action :auth_user

	def welcome
		@news = News.new
		@root = true
		if flash.empty?
			flash_message('notice', t('flash_messages.welcome'))
		end
		render 'public/welcome'
	end

	def terms
		render 'public/terms'
	end

	private

    def news_params
      params.require(:news).permit(:zipcode, :email, :country)
    end

end
