@init_welcome = ->
	$('#btn_arrow').click () ->
		$.fn.fullpage.moveTo(2)