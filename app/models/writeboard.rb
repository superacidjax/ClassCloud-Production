class Writeboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :class_room
<<<<<<< HEAD
<<<<<<< HEAD
  validates :title, :body, :presence => true
  acts_as_commentable
=======

  validates :title, :body, :presence => true
  
  acts_as_commentable
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  validates :title, :body, :presence => true
  acts_as_commentable
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  acts_as_textiled :title, :body
  acts_as_voteable
end
