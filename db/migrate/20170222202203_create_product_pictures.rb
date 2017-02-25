class CreateProductPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :product_pictures do |t|
    	t.references :product, index: true, foreign_key: true
		t.boolean :main, default: true
		t.boolean :activated, default: true
		t.text :image
    end
  end
end
