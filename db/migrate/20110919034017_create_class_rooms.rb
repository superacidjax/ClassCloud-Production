class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :class_rooms, :user_id
  end
end
