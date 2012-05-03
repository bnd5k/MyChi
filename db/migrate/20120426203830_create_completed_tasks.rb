class CreateCompletedTasks < ActiveRecord::Migration
  def change
    create_table :completed_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.timestamps
    end 
  end
end
