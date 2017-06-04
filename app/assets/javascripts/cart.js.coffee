@init_cart = ->
	$('#total-price.btn').click (ev) ->
		$('#new_order_line').submit();
	$('#order_delivery_method_delivery').click (ev) ->
		$('.del_details').slideDown(1000)
		#$('.collect').fadeOut()
		#$('.delivery').fadeIn()
		#$('body, html, #delivery_details').scrollTop(0)
		#$('#delivery_details').animate({ scrollTop: 0 }, .2)
	$('#order_delivery_method_collect, #adress_validate').click (ev) ->
		$('.del_details').slideUp(1000)
		#$('html, body').scrollTop()
	$('#order_delivery_method_collect').click (ev) ->
		#$('.collect').fadeIn()
		#$('.delivery').fadeOut()