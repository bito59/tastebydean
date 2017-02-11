window.App ||= {}

App.init = ->
	init_fullpage()
	init_flash()
	init_devise_modal()
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
		$(this).fadeOut 500, ->
			$(this).empty()

# Init devise modal
init_devise_modal = ->
	# Block links under modal
	$(".a").click (ev) ->
		if $(this).hasClass("blocked") == true
      		ev.preventDefault()
	# Show modal
	$('.connect_modal').on 'click', ->
		remove_mb_menu()
		add_modal()
	# Hide modal
	$(window).on 'click', ->
		#if !$(event.target).parents('.no-hide').length && !$(event.target).is(".no-hide")
		if !$(event.target).parents('.front').length
			remove_modal()
	$('.register-link').on 'click', -> 
		remove_modal()

# Init mobile menus
init_mobile_menu = ->
	$('#open_mb_main_menu').click ->
		add_mb_menu()
		disable_fp()

	$('.close_mb_menu').click ->
		remove_mb_menu()
		enable_fp()

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
	, 4000
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

add_mb_menu = ->
	$('#mb_main_menu').fadeIn 500
	$('.mb-hide').hide()
remove_mb_menu = ->
	$('.mb-menu').fadeOut 500
	$('.mb-hide').fadeIn 500

add_modal = ->
	$('#devise_modal').fadeIn(500)
	$(".modal-fade a").addClass("blocked")
remove_modal = ->
	$('#devise_modal').fadeOut(500)
	$(".modal-fade a").removeClass("blocked")

disable_fp = ->
	if $(".section")[0]
		console.log 'fullpage exist (enter)'
		$.fn.fullpage.setAllowScrolling(false);
		$.fn.fullpage.setAutoScrolling(false);
enable_fp = ->
	if $(".section")[0]
		console.log 'fullpage exist (exit)'
		$.fn.fullpage.setAllowScrolling(true);
		$.fn.fullpage.setAutoScrolling(true);
		$.fn.fullpage.silentMoveTo(1);
