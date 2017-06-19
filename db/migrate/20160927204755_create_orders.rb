class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|

		t.references :user, index: true
		t.string :serial
		t.string :status

		# Delivery infos
		t.string :delivery_method
		t.string :title
		t.string :name
		t.string :surname
		t.string :address
		t.string :zipcode
		t.string :city
		t.string :country
		t.string :phone

		# Fees
		t.decimal :subtotal, precision: 12, scale: 3, default: 0
		t.decimal :shipping_fees, precision: 12, scale: 3, default: 0
		t.decimal :tax_fees, precision: 12, scale: 3, default: 0
		t.decimal :share_discount, default: 0
		t.decimal :num_discount, precision: 12, scale: 3, default: 0
		t.decimal :total, precision: 12, scale: 3, default: 0
		t.references :price_unit, index: true

		# Payment
		t.string :payment_method
		t.string :payment_type
		t.string :payment_status

		# Dates
		t.datetime :creation_date
		t.datetime :validation_date
		t.datetime :confirmation_date
		t.datetime :expedition_date
		t.datetime :payment_date

		t.timestamps null: false
    end
  end
end
