class CreateOrderLines < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lines do |t|
    	t.references :order, foreign_key: true, index: true
		t.references :product, foreign_key: true, index: true
		t.references :fabric, foreign_key: true, index: true

		# Production
		t.boolean :std_size, default: true
		t.boolean :sep_fabric, default: true

		# Prices
		t.decimal :confection_price, precision: 12, scale: 3, default: 0
		t.decimal :fabric_price, precision: 12, scale: 3, default: 0
		t.decimal :unit_price, precision: 12, scale: 3, default: 0
		t.integer :quantity, default: 1
		t.decimal :total_price, precision: 12, scale: 3, default: 0
		t.references :price_unit, index: true

		t.timestamps null: false
    end
  end
end
