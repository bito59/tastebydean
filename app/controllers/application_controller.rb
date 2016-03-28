class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception
	add_flash_types :success, :warning, :info

	before_filter :authenticate_user!
	before_filter :configure_permitted_parameters, if: :devise_controller?
	before_action :find_user, :set_locale

	# Add-on for using devise in apps modal
	helper_method :resource_name, :resource, :devise_mapping

	private

	def find_user
		if current_user.present?
			@user = User.friendly.find(current_user[:id])
		end
	end
 
 	# Choose language to use
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
	  { locale: I18n.locale }.merge options
	end

	# Add properties to User with devise
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:pseudo, :email, :password, :password_confirmation, :current_password) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:pseudo, :email, :password, :password_confirmation, :current_password) }
	end

	# Devise rerouting customization
	def after_sign_in_path_for(resource)
		request.referrer
	end
	def after_sign_out_path_for(resource)
		#root_path
		session["user_return_to"] || root_path
	end

end
