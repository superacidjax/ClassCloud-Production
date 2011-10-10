class ClassRoomStudent < ActiveRecord::Base
  belongs_to :student, :class_name => "User", :foreign_key => "user_id"
  belongs_to :class_room
end
