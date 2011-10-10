class ClassRoom < ActiveRecord::Base
  belongs_to :user
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
  validates :name, :user_id, :presence => true
  validates :name, :uniqueness => {:scope => :user_id}
end
