class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale, :current_order
  before_action :store_current_location, unless: :devise_controller?
  before_action :auth_user
  helper_method :current_order

  def current_order
    if user_signed_in?
      if current_user.orders.status('basket').present?
        order = current_user.orders.status('basket').last
        set_order_session(order)
      else
        if Order.find_by(id: session[:order_id]).present?
          order = Order.find_by(id: session[:order_id])
        else
          # session doesnt fit to any order (problem occured)
          session.delete :order_id
          order = Order.new
        end 
      end
    else
      session.delete :order_id
      order = Order.new
    end
    order
  end
  
  #sets the session once order is saved
  def set_order_session(order)
    session[:order_id] = order.id
    #puts "session_order_id #{session[:order_id]}"
  end

  def search_order_session
    if Order.find_by(id: session[:order_id]).present?

  end
    
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    puts 'current order : ' + current_order.inspect
  end

  def find_fabric_price(product_id, fabric_id, std_size)
    product = Product.friendly.find(product_id)
    fabric_family_id = Fabric.friendly.find(fabric_id).fabric_family.id
    pricing = product.product_family.fabric_prices.where(fabric_family_id: fabric_family_id).first
    unless std_size.nil?
      # Pb boolean avec ajax js
      if std_size == 'false' #|| std_size == false
        fabric_price = pricing.price_big
      elsif
        fabric_price = pricing.price_std
      end
    else
      #By default it is std size
      fabric_price = pricing.price_std
    end
    puts 'fabric price calculated is : ' + fabric_price.to_s
    fabric_price
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
