class CreateProductFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :product_families do |t|
    	t.string :title
      	t.timestamps
    end
  end
end
