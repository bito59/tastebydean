class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :store_current_location, unless: :devise_controller?
  before_action :auth_user
  helper_method :current_order

  def current_order
    if !session[:order_id].nil? && Order.exists?(session[:order_id])
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_in_path_for(user)
    request.referrer || root_path
  end

  def after_sign_out_path_for(user)
    root_path
  end

  def auth_user
    unless user_signed_in?
      flash_message('alert', 'Please create an account first')
      redirect_to request.referrer
    end
  end

end
