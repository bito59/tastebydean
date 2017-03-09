# Creation of users
User.delete_all
user = User.new( email: 'bitocreator@gmail.com', password: "fouesnant", password_confirmation: "fouesnant", zipcode: "59000", newsletter: true )
#user.add_role :admin
user.save

# Creation of customer
#Customer.create(title: 'Mme', name: 'Denin', surname: 'Michelle', 
	#adress: 'rue de la rue', zipcode: '59000', city: 'Lille', country: 'France', 
	#phone: '0320202020', email: 'poubellebito@gmail.com')
#Customer.create(title: 'Mlle', name: 'Ouzou', surname: 'Louise', 
	#adress: 'rue de léglise', zipcode: '59110', city: 'La Madeleine', country: 'France', 
	#phone: '0310101010', email: 'poubellebito@gmail.com')
#Customer.create(title: 'Mr', name: 'Leblanc', surname: 'René', 
	#adress: 'rue de la montagne', zipcode: '59170', city: 'Croix', country: 'France', 
	#phone: '0330303030', email: 'poubellebito@gmail.com')


# Creation of products
Product.delete_all
(1..20).each do |p|
	kind = Product.kinds.sample(1).to_sym
	customer = Product.customers.sample(1).to_sym
	family = Product.families.sample(1).to_sym
	price = ["2", "3", "4", "5", "6", "7", "8", "9", "10"].sample
	unit = Product.price_units.sample(1).to_sym
	title = 'Elegance ' + p.to_s
	product = Product.new(	serial: p,
							title: title,
							kind: kind,
							customer: customer,
							family: family,
							price: price,
							price_unit: unit,
							leadtime: p,
							description: 'Un produit sympa pour ta fête !' 
	)
	if p.even? && kind == 'model'
		product[:activated] = true
		product[:unic_fabric] = true
		product[:unic_size] = false
		product[:fabric_lng_std] = 1
		product[:fabric_lrg_std] = 0.5
        product[:fabric_lng_big] = 1.5
        product[:fabric_lrg_big] = 0.5
        product[:on_measure] = true
	else
		product[:activated] = true
		product[:unic_fabric] = true
		product[:unic_size] = true
		product[:on_measure] = false

	end
	product.save
	#product.product_pictures.create({
	#	image: File.open("#{Rails.root}/app/assets/images/image_sample/product_sample.jpg"),
	#	main: true,
	#	activated: true
	#})	
end

# Creation of fabrics
Fabric.delete_all
(1..10).each do |p|
	kind = Fabric.kinds.sample(1).to_sym
	family = Fabric.families.sample(1).to_sym
	price = ["2", "3", "4", "5", "6", "7", "8", "9", "10"].sample
	unit = Fabric.price_units.sample(1).to_sym
	title = 'Tissu  ' + p.to_s
	fabric = Fabric.new(	serial: p,
							activated: true,
							title: title,
							kind: kind,
							family: family,
							price: price,
							price_unit: unit,
							description: 'Cest très beau'
	)
	fabric.save
end

Measure.delete_all
Measure.create(title: 'Simple', around_collar_large: true)
Measure.create(title: 'More', around_collar_large: true, shoulder_width: true)
Measure.create(title: 'Complex', around_collar_large: true, shoulder_width: true, shoulder_waist_front_large: true)

# Creation of orders
Order.delete_all
OrderLine.delete_all
