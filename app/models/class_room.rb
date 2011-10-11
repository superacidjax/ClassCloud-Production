class ClassRoom < ActiveRecord::Base
  belongs_to :user
  
  with_options :dependent => :destroy do |assignment|
    assignment.has_many :events
    assignment.has_many :assignments
    assignment.has_many :class_room_students
    assignment.has_many :class_room_observers
    assignment.has_many :writeboards
    assignment.has_many :discussions
    assignment.has_many :notes
    assignment.has_many :activity_streams
  end

  has_many :students, :through => :class_room_students, :class_name => "User", :foreign_key => :user_id
  has_many :observers, :through => :class_room_observers, :class_name => "User", :foreign_key => :user_id

  validates :name, :user_id, :presence => true
  #validates :name, :uniqueness => {:scope => :user_id}
end
