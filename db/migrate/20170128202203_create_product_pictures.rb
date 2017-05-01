class CreateProductPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :product_pictures do |t|
    	t.references :product, foreign_key: true, index: true
		t.boolean :main, default: false
		t.boolean :activated, default: true
		t.text :image
    end
  end
end
