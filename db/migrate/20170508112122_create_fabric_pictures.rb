class CreateFabricPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :fabric_pictures do |t|
		t.references :fabric, foreign_key: true, index: true
		t.boolean :activated, default: true
		t.boolean :main, default: false
		t.boolean :preview, default: false
		t.text :image
      	t.timestamps
    end
  end
end
