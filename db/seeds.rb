User.delete_all
Order.delete_all
OrderLine.delete_all
Measure.delete_all
Product.delete_all
Fabric.delete_all
Customer.delete_all
FabricPrice.delete_all
ProductFamily.delete_all
FabricFamily.delete_all
PriceUnit.delete_all
ProductPicture.delete_all

user = User.create( email: 'bitocreator@gmail.com', password: "fouesnant", password_confirmation: "fouesnant", zipcode: "59000", newsletter: true )

Measure.create(title: 'Simple', around_collar_large: true)
Measure.create(title: 'More', around_collar_large: true, shoulder_width: true)
Measure.create(title: 'Complex', around_collar_large: true, shoulder_width: true, shoulder_waist_front_large: true)

Customer.create(title: 'Man')
Customer.create(title: 'Woman')
Customer.create(title: 'Boy')
Customer.create(title: 'Girl')
Customer.create(title: 'Adult')
Customer.create(title: 'Child')
Customer.create(title: 'All')

ProductFamily.create(title: 'dress')
ProductFamily.create(title: 'vest')
ProductFamily.create(title: 'neck-tie')
ProductFamily.create(title: 'bow-tie')
ProductFamily.create(title: 'tie')
ProductFamily.create(title: 'scarf-ascot')

FabricFamily.create(title: 'wool')
FabricFamily.create(title: 'silk')
FabricFamily.create(title: 'cotton')
FabricFamily.create(title: 'linen')

PriceUnit.create(title: '€')
PriceUnit.create(title: 'Kyat')
PriceUnit.create(title: 'USD')

ProductFamily.all.each do |p|
	FabricFamily.all.each do |f|
		FabricPrice.create(
			title: f.title + '-' + p.title,
			product_family_id: p.id,
			fabric_family_id: f.id,
			price_std: 5,
			price_big: 6,
		)
	end
end

# Creation of products
(1..20).each do |p|
	kind = Product.kinds.sample(1).to_sym
	customer = Customer.order("RAND()").first
	family = ProductFamily.order("RAND()").first
	confection_price = ["2", "3", "4", "5", "6", "7", "8", "9", "10"].sample
	title = 'Elegance ' + p.to_s
	product = Product.new(	serial: p,
							title: title,
							kind: kind,
							customer_id: customer.id,
							product_family_id: family.id,
							confection_price: confection_price,
							leadtime: p,
							description: 'Un produit sympa pour ta fête !',
							# production
							fabric_lng_std: 100,
							fabric_lrg_std: 50,
							fabric_lng_big: 150,
							fabric_lrg_big: 50, 
	)
	if p.even? && kind == 'model'
		product[:activated] = true
		product[:custom_fabric] = true
		product[:unic_size] = true
        product[:on_measure] = true
	else
		product[:activated] = true
		product[:custom_fabric] = false
		product[:unic_size] = true
		product[:on_measure] = false

	end
	product.save
end

# Creation of fabrics
(1..10).each do |p|
	#kind = Fabric.kinds.sample(1).to_sym
	family = FabricFamily.order("RAND()").first
	title = 'Tissu  ' + p.to_s
	fabric = Fabric.new(	serial: p,
							activated: true,
							title: title,
							#kind: kind,
							fabric_family_id: family.id,
							description: 'Cest très beau'
	)
	fabric.save
end
