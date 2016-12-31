class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

    	# Commercial 
    	t.string :serial
    	t.boolean :activated, default: false
    	t.string :kind
    	t.string :customer
    	t.string :family
    	t.string :title
    	t.text :description
    	t.decimal :price, precision: 8, scale: 2
    	t.string :price_unit

		# Logistic
		t.boolean :on_measure
		t.boolean :custom_fabric
		t.float :fab_length #only if limited_fabric
		t.string :fab_length_unit #only if limited_fabric

		t.timestamps null: false
        t.string :slug
    end
    add_index :products, :slug, unique: true
  end
end
