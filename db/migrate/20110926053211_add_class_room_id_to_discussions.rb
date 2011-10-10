class AddClassRoomIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :class_room_id, :integer
    add_index :discussions, :class_room_id
  end
end
