class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :image
      t.belongs_to :gallery, index: true

      t.timestamps null: false
    end
  end
end
