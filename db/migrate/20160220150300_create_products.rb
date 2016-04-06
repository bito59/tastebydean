class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :serial
      t.string :title
      t.string :kind
      t.string :customer
      t.string :family
      t.string :description
      t.boolean :activated, default: false
      t.text :event
      t.decimal :price, precision: 8, scale: 2
      t.string :price_unit
      t.float :measure
      t.string :measure_unit
      t.string :slug
      t.timestamps null: false
    end
    add_index :products, :slug, unique: true
  end
end
