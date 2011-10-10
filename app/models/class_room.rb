class ClassRoom < ActiveRecord::Base
  belongs_to :user
<<<<<<< HEAD
  has_many :events, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_many :class_room_students, :dependent => :destroy
  has_many :class_room_observers, :dependent => :destroy
  has_many :students, :through => :class_room_students, :class_name => "User", :foreign_key => :user_id
  has_many :observers, :through => :class_room_observers, :class_name => "User", :foreign_key => :user_id
  has_many :writeboards, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :activity_streams, :dependent => :destroy
=======

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

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  validates :name, :user_id, :presence => true
  validates :name, :uniqueness => {:scope => :user_id}
end
