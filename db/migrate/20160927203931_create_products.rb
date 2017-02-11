class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

    	# Commercial 
    	t.string :serial
    	t.boolean :activated, default: false
    	t.string :kind
    	t.string :customer
    	t.string :family
    	t.string :title
    	t.text :description
    	t.decimal :price, precision: 8, scale: 2
    	t.string :price_unit

        # Logistic 
        t.string :lead_time #min lead time announced for production

		# Production
		t.boolean :custom_fabric #customer can choose his fabric or not
		t.float :fabric_lgt_std #fabric lenght for std size
		t.float :fabric_lrg_std #fabric lenght for std size
        # Fabric size needed, only if custom fabric true and unic size false
        t.boolean :variable_size, default: false #large size of not
        t.float :fabric_lgt_big #fabric lenght for big size
        t.float :fabric_lrg_big #fabric lenght for big size

        t.boolean :on_measure #customer can specify measures or not
        # Customer measures infos, only if on measure true
        t.boolean :around_collar_large
        t.boolean :shoulder_width
        t.boolean :shoulder_waist_front_large
        t.boolean :shoulder_waist_back_large
        t.boolean :back_width
        t.boolean :chest_width
        t.boolean :around_bust_large
        t.boolean :bust_height
        t.boolean :around_waist_large
        t.boolean :elbow_length
        t.boolean :around_arm_large
        t.boolean :arm_lenght
        t.boolean :around_hip_height
        t.boolean :around_hip_large
        t.boolean :half_hip_height
        t.boolean :crotch_length
        t.boolean :knee_lenght
        t.boolean :leg_length
        t.boolean :inside_leg_length
        t.boolean :around_leg_large
        t.boolean :total_height

		t.timestamps null: false
        t.string :slug
    end
    add_index :products, :slug, unique: true
  end
end
