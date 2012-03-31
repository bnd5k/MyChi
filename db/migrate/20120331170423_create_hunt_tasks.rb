class CreateHuntTasks < ActiveRecord::Migration
  def change
    create_table :hunt_tasks do |t|
      t.integer :hunt_id
      t.integer :task_id
      t.timestamps
    end
    add_index :hunt_tasks, :hunt_id
    add_index :hunt_tasks, :task_id
    add_index :hunt_tasks, [:hunt_id, :task_id], :unique => true
  end
end
