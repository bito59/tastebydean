class CreateMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :measures do |t|
    	t.string :title

		t.boolean :around_collar_large, default: false
        t.boolean :shoulder_width, default: false
        t.boolean :shoulder_waist_front_large, default: false
        t.boolean :shoulder_waist_back_large, default: false
        t.boolean :back_width, default: false
        t.boolean :chest_width, default: false
        t.boolean :around_bust_large, default: false
        t.boolean :bust_height, default: false
        t.boolean :around_waist_large, default: false
        t.boolean :elbow_length, default: false
        t.boolean :around_arm_large, default: false
        t.boolean :arm_lenght, default: false
        t.boolean :around_hip_height, default: false
        t.boolean :around_hip_large, default: false
        t.boolean :half_hip_height, default: false
        t.boolean :crotch_length, default: false
        t.boolean :knee_lenght, default: false
        t.boolean :leg_length, default: false
        t.boolean :inside_leg_length, default: false
        t.boolean :around_leg_large, default: false
        t.boolean :total_height, default: false

      	t.timestamps
    end
  end
end
