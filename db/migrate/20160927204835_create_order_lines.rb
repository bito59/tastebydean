class CreateOrderLines < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lines do |t|
		t.references :product, index: true, foreign_key: true
		t.references :order, index: true, foreign_key: true

		# Fabrics, only if model
		t.references :fabric, index: true, foreign_key: true

		# Prices
		t.integer :quantity
		t.decimal :unit_price, precision: 12, scale: 3
		t.decimal :fabric_price, precision: 12, scale: 3
		t.decimal :total_price, precision: 12, scale: 3

		# Customer sizes infos, only if product not unic_size
		t.decimal :around_collar_large
		t.decimal :shoulder_width
		t.decimal :shoulder_waist_front_large
		t.decimal :shoulder_waist_back_large
		t.decimal :back_width
		t.decimal :chest_width
		t.decimal :around_bust_large
		t.decimal :bust_height
		t.decimal :around_waist_large
		t.decimal :elbow_length
		t.decimal :around_arm_large
		t.decimal :arm_lenght
		t.decimal :around_hip_height
		t.decimal :around_hip_large
		t.decimal :half_hip_height
		t.decimal :crotch_length
		t.decimal :knee_lenght
		t.decimal :leg_length
		t.decimal :inside_leg_length
		t.decimal :around_leg_large
		t.decimal :total_height

		t.timestamps null: false
    end
  end
end
