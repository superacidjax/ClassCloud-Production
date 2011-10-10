class ClassRoomObserver < ActiveRecord::Base
  belongs_to :observer, :class_name => "User", :foreign_key => "user_id"
  belongs_to :class_room
end
