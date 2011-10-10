class CreateClassRoomStudents < ActiveRecord::Migration
  def change
    create_table :class_room_students do |t|
      t.integer :user_id
      t.integer :class_room_id

      t.timestamps
    end
    add_index :class_room_students, :user_id
    add_index :class_room_students, :class_room_id
  end
end
