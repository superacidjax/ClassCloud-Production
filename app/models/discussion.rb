class Discussion < ActiveRecord::Base
  acts_as_commentable
<<<<<<< HEAD
<<<<<<< HEAD
  belongs_to :user
  belongs_to :class_room
=======

  belongs_to :user
  belongs_to :class_room
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  belongs_to :user
  belongs_to :class_room
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  validates :title, :description, :user_id, :class_room_id, :presence => true
  validates :title, :uniqueness => {:scope => [:user_id, :class_room_id]}
end
