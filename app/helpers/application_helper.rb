module ApplicationHelper

	# --------    Helpers for flash messages display -----------------------------------------
	def flash_message (type, text)
		flash[type] ||= []
		flash[type] << text
	end

	def render_flash
		rendered = []
  		flash.each do |type, msg|
  			if msg.class == Array
  				msg.each do |message|
  					content = ""
  					if message.class == Array
  						content = message[0].to_s + " " + message[1][0].to_s
  					else
  						content = message
  					end
  					rendered << content_tag(:div, content, class: "flash_#{type}")
  				end
  			else
  				rendered << content_tag(:div, msg, class: "flash_#{type}")   			
  			end
	  	end
		rendered.join().html_safe
	end	

	def flash_class(level)
	    case level
	        when 'notice' then "alert alert-dismissable alert-info"
	        when 'error' then "alert alert-dismissable alert-danger"
	        when 'alert' then "alert alert-dismissable alert-danger"

	       	when 'success' then "alert alert-dismissable alert-success"
	       	when 'warning' then "alert alert-dismissable alert-success"
	       	when 'info' then "alert alert-dismissable alert-success"
	    end
	end


	# --------    Helpers for modal devise -----------------------------------------
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end


	# --------    Helpers for languages -----------------------------------------
	def alternate_locales
	  # Remove current locale from list
	  aval_locales_but_current = I18n.available_locales - [locale]


	end

	def flag(language, width, height)
		image_tag('flags/' + language.to_s + '.jpg', width: width, height: height)
	end

	# --------    Helpers for icons -----------------------------------------
	def icon(name, width, height)
		image_tag('icons/' + name.to_s + '.jpg', width: width, height: height)
	end

end
