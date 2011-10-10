class Note < ActiveRecord::Base
  acts_as_commentable
<<<<<<< HEAD
  belongs_to :user
  belongs_to :class_room
  validates :title, :description, :user_id, :class_room_id, :presence => true
  validates :title, :uniqueness => {:scope => [:user_id, :class_room_id]}
  acts_as_textiled :description
=======

  belongs_to :user
  belongs_to :class_room
  
  validates :title, :description, :user_id, :class_room_id, :presence => true
  validates :title, :uniqueness => {:scope => [:user_id, :class_room_id]}
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
