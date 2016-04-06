user = User.new( email: 'bitocreator@gmail.com', password: "fouesnant", password_confirmation: "fouesnant", pseudo: "thib" )
user.add_role :admin
user.save

(1..50).each do |p|
	p.to_i
	kind = Product::KINDS.sample
	if kind == 'material'
		customer = 'all'
	else
		customer = Product::CUSTOMERS.sample
	end
	if customer == 'man' || customer == 'boy'
		family = Product::FAMILIES[:male].sample
	elsif customer == 'woman' || customer == 'girl'
		family = Product::FAMILIES[:female].sample
	elsif customer == 'all'
		family = Product::FAMILIES[:material].sample
	end
	serial = 'D1600' + p.to_s
	title = 'product' + p.to_s
	product = Product.new(	serial: serial,
							title: title,
							kind: kind,
							customer: customer,
							family: family,
							price: p,
							price_unit: '€',
							measure: p,
							measure_unit: 'meter')
	if p.even?
		product[:activated] = true
	end
	product.save!
end