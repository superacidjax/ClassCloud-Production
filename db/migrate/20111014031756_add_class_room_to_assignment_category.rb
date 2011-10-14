class AddClassRoomToAssignmentCategory < ActiveRecord::Migration
  def change
     add_column :assignment_categories, :class_room_id, :integer
  end
end
