class CreateFabricPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :fabric_prices do |t|
    	# Main datas 
    	t.string :title
    	t.references :product_family, foreign_key: true, index: true
    	t.references :fabric_family, foreign_key: true, index: true

        # Commercial
        t.decimal :price_std, precision: 8, scale: 2
        t.decimal :price_big, precision: 8, scale: 2
    	t.string :price_unit, default: '€'

      t.timestamps
    end
  end
end
