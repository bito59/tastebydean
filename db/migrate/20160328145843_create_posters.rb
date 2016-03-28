class CreatePosters < ActiveRecord::Migration
	def change
		create_table :posters do |t|
			t.string :title
      		t.string :text
      		t.boolean :activated
			t.attachment :image
			t.timestamps null: false
		end
	end
end
