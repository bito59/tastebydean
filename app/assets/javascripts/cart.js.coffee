@init_cart = ->
	$('#order_delivery_method_delivery').click (ev) ->
		ev.stopPropagation()
		$('.del_details').slideDown(1000)
		delivery_method = $('#order_delivery_method_delivery').val()
		update_final_price(delivery_method)
		console.log ('delivery_method : ' + delivery_method)

	$('#order_delivery_method_collect').click (ev) ->
		ev.stopPropagation()
		$('.del_details').slideUp(1000)
		delivery_method = $('#order_delivery_method_collect').val()
		update_final_price(delivery_method)
		console.log ('delivery_method : ' + delivery_method)

	$('#adress_validate').click (ev) ->
		$('.del_details').slideUp(1000)

@update_final_price = (x) ->
	$.ajax
		url: Routes.shop_update_final_price_path(),
		dataType: 'script',
		data: { delivery_method: x },
		success: (data) ->    
			console.log("ajax successly fired")