class CreateUploads < ActiveRecord::Migration
  def change
  	create_table :uploads do |t|
	  	t.attachment :uploaded_file
	  	t.belongs_to :gallery, index: true
	  	t.timestamps
	end
  end
end
