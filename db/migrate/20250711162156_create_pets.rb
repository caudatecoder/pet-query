class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :type, null: false
      t.string :tracker_type, null: false
      t.integer :owner_id, null: false

      t.boolean :in_zone, null: false
      t.boolean :lost_tracker

      t.timestamps

      t.index :type
    end
  end
end
