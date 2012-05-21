class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :trip_name
      t.references :user
      t.references :hunt
      t.timestamps
    end
    add_index :trips, :hunt_id
    add_index :trips, :user_id
    add_index :trips, [:hunt_id, :user_id], :unique => true
  end
end
