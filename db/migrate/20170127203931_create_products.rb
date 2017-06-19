class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

    	# Main datas 
    	t.string :serial
        t.string :title
    	t.boolean :activated, default: false
    	t.integer :kind, default: 1
    	t.references :customer, index: true
    	t.references :product_family, foreign_key: true, index: true
        t.references :measure

        # Commercial
    	t.text :description
    	t.decimal :confection_price, precision: 8, scale: 2
    	t.references :price_unit, index: true

		# Production
        t.string :leadtime #leadtime for production
        t.boolean :custom_fabric, default: true #customer can choose his fabric or not
        t.boolean :on_measure, default: true #customer will specify his dimensions
        t.boolean :unic_size, default: true #customer can choose standard or large
        t.float :fabric_lng_std #fabric lenght for std size
        t.float :fabric_lrg_std #fabric lenght for std size
        t.float :fabric_lng_big #fabric lenght for large size
        t.float :fabric_lrg_big #fabric lenght for large size

		t.timestamps null: false
        t.string :slug
    end
    add_index :products, :slug, unique: true
  end
end
