class NewsController < ApplicationController
	include ApplicationHelper

	skip_before_action :auth_user

	def create
		@news = News.new(news_params)
		respond_to do |format|
			if @news.save
				@news = News.new
				flash_message('success', t('flash_messages.news_created'))
				format.js { render 'welcome/create_news.js.erb' }
			else
				flash_message('alert', t('flash_messages.news_problem'))
			end
		end
	end
  

  private

  def news_params
  	params.require(:news).permit(:zipcode, :email)
  end
end
