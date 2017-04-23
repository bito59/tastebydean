class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

    	# Main datas 
    	t.string :serial
    	t.boolean :activated, default: false
    	t.integer :kind, default: 1
    	t.integer :customer, default: 1
    	t.integer :family, default: 1
    	t.string :title
        t.references :measure, foreign_key: true

        # Commercial
    	t.text :description
    	t.decimal :price, precision: 8, scale: 2
    	t.integer :price_unit, default: 1

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
