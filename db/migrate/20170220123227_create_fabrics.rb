class CreateFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :fabrics do |t|
  		# Main datas 
  		t.string :serial
    	t.boolean :activated, default: false
    	t.string :kind
    	t.string :title
    	t.text :image
      # Commercial
    	t.text :description
    	t.decimal :price, precision: 8, scale: 2 #Price per metter length
    	t.string :price_unit

      t.timestamps
      t.string :slug
    end
  end
end
