class CreateFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :fabrics do |t|
  		# Main datas 
  		t.string :serial
    	t.boolean :activated, default: false
    	t.integer :kind, default: 1
      t.integer :family, default: 1
    	t.string :title
    	t.text :image
      # Commercial
    	t.text :description
    	t.decimal :price, precision: 8, scale: 2 #Price per metter length
    	t.integer :price_unit, default: 1
       # Production
      t.string :origin
      t.string :content

      t.timestamps
      t.string :slug
    end
  end
end
