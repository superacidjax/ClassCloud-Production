class Discussion < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :class_room
  belongs_to :user
  belongs_to :class_room
  belongs_to :user
  belongs_to :class_room
  validates :title, :description, :user_id, :class_room_id, :presence => true
  validates :title, :uniqueness => {:scope => [:user_id, :class_room_id]}
  acts_as_textiled :description
end
