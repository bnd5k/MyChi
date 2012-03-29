class CreateHunts < ActiveRecord::Migration
  def change
    create_table :hunts do |t|
      t.string :name

      t.timestamps
    end
  end
end
