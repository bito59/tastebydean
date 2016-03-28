class UsersController < ApplicationController

	before_action :find_user, only: [:show, :update]

	def show	
		redirect_to root_path
	end

	def edit
		respond_to do |format|
			format.js   { render 'admin/users/edit.js.erb' }
		end
	end

	def update
		@user.slug = nil
		respond_to do |format|
			if @user.update(user_params)
				format.js   { render 'admin/users/update.js.erb' }
			else
			end
		end
	end

	def destroy
		respond_to do |format|
			if @user.destroy
				format.html { redirect_to root_path, notice: "The account has been deleted. Bye !" }
				format.js   { render 'admin/products/destroy.js.erb' }
			end
		end
	end

  	private

	def user_params
		params.require(:user).permit(:pseudo, :avatar, :slug)
	end

	def find_user
		if current_user.present?
			@user = current_user
		end
	end

end
