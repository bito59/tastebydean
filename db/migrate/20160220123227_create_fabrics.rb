class CreateFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :fabrics do |t|

  		# Main datas 
  		t.string :serial
      t.string :kind, default: 'fabric' # Needed to use the kind key in product show pages
    	t.string :title
      t.references :fabric_family, foreign_key: true, index: true
      t.boolean :activated, default: false

      # Commercial
      t.string :origin
      t.string :content
      t.text :description

      # Production
      t.float :stock_length

      t.timestamps
      t.string :slug
    end
  end
end
