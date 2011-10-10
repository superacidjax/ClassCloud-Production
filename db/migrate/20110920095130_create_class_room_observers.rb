class CreateClassRoomObservers < ActiveRecord::Migration
  def change
    create_table :class_room_observers do |t|
      t.integer :user_id
      t.integer :class_room_id

      t.timestamps
    end
    add_index :class_room_observers, :user_id
    add_index :class_room_observers, :class_room_id
  end
end
