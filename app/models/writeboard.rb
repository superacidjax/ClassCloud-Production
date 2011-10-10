class Writeboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :class_room
<<<<<<< HEAD
  validates :title, :body, :presence => true
  acts_as_commentable
=======

  validates :title, :body, :presence => true
  
  acts_as_commentable
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  acts_as_textiled :title, :body
  acts_as_voteable
end
