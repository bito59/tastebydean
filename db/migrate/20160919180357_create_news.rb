class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :zipcode
      t.string :email
      t.string :country

      t.timestamps
    end
  end
end
