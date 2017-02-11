window.App ||= {}

App.init = ->
	init_fullpage()
	init_flash()
	init_boostrap_modal()
	init_mobile_menu()


$(document).on "turbolinks:load", ->
  	App.init()


# -------------------------------  JS init functions  --------------------------------------------

# Init fullpage
init_fullpage = ->
	if typeof $.fn.fullpage.destroy == 'function'
	    $.fn.fullpage.destroy('all');
	    console.log 'fullpage destroyed (all)'
	if (screen.width < 1024 && $(".section")[0]) || $(".section-dk")[0]
		console.log 'fullpage loaded'
		$('#footer').hide();
		$('#main').fullpage
			fitToSectionDelay: 10000
			scrollOverflow: true
			afterLoad: (anchor, index) ->
				if $('.active').hasClass 'dyn-header' #anchor == 1
					$('#header').fadeIn('slow');
				if $('.active').hasClass 'dyn-footer' #anchor == 4
					$('#footer').fadeIn('slow');   	
			onLeave: (anchor, index) ->
				if $('.active').hasClass 'dyn-header'
					$('#header').fadeOut 'slow'
				if $('.active').hasClass 'dyn-footer'
					$('#footer').fadeOut 'slow'

# Init flash
init_flash = ->
	$('#flash_msg').hide()
	console.log 'Flash loaded'
	unless $('#flash_msg').length is 0
		show_flash()
	$('#flash_msg').change ->
		show_flash()
	$('.flash').click ->
		$(this).fadeOut 2000, ->
			$(this).empty()

# Init bootstrap modal for user log in
init_boostrap_modal = ->
	# Block links under modal
	$(".a").click (ev) ->
		if $(this).hasClass("blocked") == true
      		ev.preventDefault()
	# Show modal
	$('#connection_modal').on 'click', ->
		$('#devise_modal').fadeIn(1000)
		$(".modal-fade a").addClass("blocked")
		$('.modal-fade').fadeTo(1000, 0.2)
	# Hide modal
	$(window).on 'click', ->
		if !$(event.target).parents('.no-hide').length && !$(event.target).is(".no-hide")
			$('#devise_modal').fadeOut(1000)
			$(".modal-fade a").removeClass("blocked")
			$('.modal-fade').fadeTo(1000, 1)
	$('.register-link').on 'click', -> 
		$('#devise_modal').fadeOut(1000)

# Init mobile menus
init_mobile_menu = ->
	$('#open_mb_main_menu').click ->
		$('#mb_main_menu').fadeIn 500
		$('.mb-hide').hide()
		if $(".section")[0]
			console.log 'fullpage exist (enter)'
			$.fn.fullpage.setAllowScrolling(false);
			$.fn.fullpage.setAutoScrolling(false);

	$('.close_mb_menu').click ->
		$('.mb-menu').fadeOut 500
		$('.mb-hide').fadeIn 500
		if $(".section")[0]
			console.log 'fullpage exist (exit)'
			$.fn.fullpage.setAllowScrolling(true);
			$.fn.fullpage.setAutoScrolling(true);
			$.fn.fullpage.silentMoveTo(1);


# -------------------------------  JS functions  --------------------------------------------
	
# Show flash messages
show_flash = ->
	setTimeout ->
		$('#flash_msg').fadeIn 1000
	, 1000
	setTimeout ->
		$('#flash_msg')
			.fadeOut 2000, ->
				$(this).empty()
	, 5000
	console.log 'Flash fired'

# Account handlers
account_handler = ->
	$('.create_account').on 'click', ->
		$('#account').fadeIn "slow"
		$('#create-account').show
		$('#connect-account').hide;
	$('.connect_account').on 'click', ->
		$('#account').fadeIn "slow"
		$('#connect-account').show
		$('#create-account').hide



