class ProductsGrid

  include Datagrid

  scope do
    Product.order("products.created_at desc")
  end

  filter(:id, :integer)
  filter(:family, :enum, :select => ["like", "ilike"], :dummy => true)
  filter(:activated, :boolean)
  #filter(:created_at, :date, :range => true)

  column(:serial_number) do |product|
    product.serial_number
  end
  column(:created_at) do |model|
    model.created_at.to_date
  end
  column(:title)
  column(:kind)
  column(:customer)
  column(:family)
  column(:description)
  column(:price)
  column(:price_unit)
  column(:measure)
  column(:measure_unit)
  column(:activated)
  column(:event)
  column(:pictures, :html => true) do |product|
    link_to count_pictures(product), gallery_path(product.id), class: "btn"
  end
  column(:edit, :html => true) do |product|
    link_to 'Edit', edit_product_path(product), remote: true, class: "btn"
  end
  column(:destroy, :html => true) do |product|
    link_to 'Destroy', product, method: :delete, remote: true, data: { confirm: 'Are you sure?' }
  end

end