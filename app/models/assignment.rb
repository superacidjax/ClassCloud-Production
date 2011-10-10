class Assignment < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :assignment_category
  belongs_to :class_room
  has_one :event, :dependent => :destroy
  has_many :assignment_students, :dependent => :destroy
  has_many :writeboards, :dependent => :destroy
  validates :title, :description, :assignment_category_id, :user_id, :presence => true
  validates :title, :uniqueness => {:scope => :user_id}
  acts_as_voteable

  belongs_to :user
  belongs_to :assignment_category
  belongs_to :class_room

  with_options :dependent => :destroy do |assignment|
    assignment.has_one :event
    assignment.has_many :assignment_students
    assignment.has_many :writeboards
  end

  has_attached_file :file,
    :content_type => ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' , 'text/plain'  ,'application/zip' , 'application/x-rar' ,'application/msword' , 'application/vnd.ms-excel' ],
    :url => ':basename.:extension',
    :path => ':rails_root/tmp/data/:basename.:extension '

  validates_attachment_content_type :file, :content_type =>
    ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ,'text/plain' ,'application/zip' , 'application/x-rar',  'application/msword' , 'application/vnd.ms-excel' ]
  validates_attachment_size :file, :less_than => 10.megabytes
  acts_as_voteable

  validates :title, :description, :assignment_category_id, :user_id, :presence => true
  validates :title, :uniqueness => {:scope => :user_id}
  acts_as_voteable

end
