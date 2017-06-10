@update_product_price = (x, y, z) ->
	$.ajax
		url: Routes.shop_update_product_price_path(),
		dataType: 'script',
		data: { id: product_id, fabric_id: fabric_id, std_size: x, sep_fabric: y, qty: z },
		#success: (data) ->    
		#console.log("ajax successly fired")

@init_shop = ->

	# Set up variables if fabric is loaded
	if $('#ol_fabric_field')[0]
		if ($('#ol_fabric_field').val().length > 0 && screen.width > 1023)
			$('.c5[data-anchor="2"]').hide()
			$('.c5[data-anchor="3"]').show()

	$('#btn_custom').click (ev) ->
		if (screen.width < 1024)
			$.fn.fullpage.moveTo(3);
		else
			$(".section[data-anchor=2]").fadeOut 500, ->
				$(".section[data-anchor=3]").fadeIn 500

	$('.cancel').click (ev) ->
		if (screen.width < 1024)
			$.fn.fullpage.moveTo(2);
		else
			$(".section[data-anchor=3]").fadeOut 500, ->
				$(".section[data-anchor=2]").fadeIn 500

	if ($(".shop_show")[0])# && ($(window).width() < 720)
		$('#header').addClass('fixed')

	$('#total-price.btn-valid').click (ev) ->
		$('#new_order_line').submit();

	$('#order_line_quantity').change () ->
		qty = $('#order_line_quantity option:selected').val()
		update_product_price(std_size, sep_fabric, qty)

	$('#order_line_std_size_true').click (ev) ->
		std_size = true
		ev.stopPropagation()
		update_product_price(std_size, sep_fabric, qty)
		$('.small_size').show()
		$('.big_size').hide()

	$('#order_line_std_size_false').click (ev) ->
		std_size = false
		ev.stopPropagation()
		update_product_price(std_size, sep_fabric, qty)
		$('.small_size').hide()
		$('.big_size').show()

	$('#order_line_sep_fabric_true').click (ev) ->
		sep_fabric = 'true'
		update_product_price(std_size, sep_fabric, qty)
		$("#order_line_sep_fabric_false").data("last-value", "")
		
	$('#order_line_sep_fabric_false').change (ev) ->
		sep_fabric = 'false'
		update_product_price(std_size, sep_fabric, qty)
		$('.full-price').show()
		$('.confection-price').hide()
		if $(this).data("last-value") == 'ok' # It was already checked
			$('#link_to_fabrics')[0].click()
		$(this).data("last-value", 'ok')
