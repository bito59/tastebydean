class CreateFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :fabrics do |t|

    	# Commercial
		t.string :serial
		t.boolean :activated, default: false
		t.string :kind
		t.string :title
		t.string :description
		t.attachment :image
		t.decimal :price, precision: 8, scale: 2
		t.string :price_unit

		# Production
		t.boolean :limited_fabric
		t.integer :stock_level
		t.string :stock_level_unit

		t.timestamps null: false
    end
  end
end

