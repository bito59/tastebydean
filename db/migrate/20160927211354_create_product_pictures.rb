class CreateProductPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :product_pictures do |t|

		t.references :product, index: true, foreign_key: true
		t.boolean :main
		t.boolean :activated
		t.attachment :image
		
		t.timestamps null: false
    end
  end
end
