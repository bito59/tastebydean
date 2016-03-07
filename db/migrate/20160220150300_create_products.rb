class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.boolean :activated
      t.string :slug
      t.string :kind
      t.string :family
      t.string :customer
      t.boolean :new_product, null: false, default: true
      t.decimal :price, precision: 8, scale: 2
      t.string :price_unit
      t.float :measure
      t.string :measure_unit

      t.timestamps null: false
    end
    add_index :products, :slug, unique: true
  end
end
