class Writeboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :class_room
  
  validates :title, :body, :presence => true
  
  acts_as_commentable
  acts_as_textiled :title, :body
  acts_as_voteable
end
