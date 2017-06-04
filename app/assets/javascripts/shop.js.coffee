@init_shop = ->
	$('#order_line_quantity').change () ->
		qty = $('#order_line_quantity option:selected').val()
		update_price(std_size, sep_fabric, qty)
	$('#order_line_std_size_true').click (ev) ->
		std_size = true
		ev.stopPropagation()
		update_price(std_size, sep_fabric, qty)
		$('.small_size').show()
		$('.big_size').hide()
	$('#order_line_std_size_false').click (ev) ->
		std_size = false
		ev.stopPropagation()
		update_price(std_size, sep_fabric, qty)
		$('.small_size').hide()
		$('.big_size').show()
	$('#order_line_sep_fabric_true').click (ev) ->
		sep_fabric = 'true'
		update_price(std_size, sep_fabric, qty)
		$("#order_line_sep_fabric_false").data("last-value", "")
	$('#order_line_sep_fabric_false').change (ev) ->
		sep_fabric = 'false'
		update_price(std_size, sep_fabric, qty)
		$('.full-price').show()
		$('.confection-price').hide()
		if $(this).data("last-value") == 'ok' # It was already checked
			$('#link_to_fabrics')[0].click()
		$(this).data("last-value", 'ok')
