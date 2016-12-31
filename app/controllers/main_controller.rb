class MainController < ApplicationController
	include ApplicationHelper

	skip_before_action :auth_user

	def welcome
		@news = News.new
		@root = true
		if flash.empty?
			#flash_message('notice', 'Welcome to tastebydean !')
		end
		render 'public/welcome'
	end

	def create_news
		@news = News.new(news_params)
	    respond_to do |format|
	      if @news.save
	      	@news = News.new
	        format.js
	      end
	    end
	end

	private

    def news_params
      params.require(:news).permit(:zipcode, :email, :country)
    end

end
