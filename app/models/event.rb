class Event < ActiveRecord::Base
  acts_as_commentable
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  has_event_calendar
  belongs_to :user
  belongs_to :class_room
  belongs_to :assignment
  validates :name, :start_at, :end_at, :user_id, :presence => true
  validates :name, :uniqueness => {:scope => :user_id}
  validate :beginning_must_before_ending_date
  scope :user_id,lambda{|user|where("user_id =?",user)}

  scope :updated_not_null,where("file_updated_at IS NOT NULL")
  def beginning_must_before_ending_date
    errors.add(:base, 'Start date must be before ending date') if self.start_at > self.end_at
  end
<<<<<<< HEAD
=======

  has_event_calendar

  belongs_to :user
  belongs_to :class_room
  belongs_to :assignment

  validates :name, :start_at, :end_at, :user_id, :presence => true
  validates :name, :uniqueness => {:scope => :user_id}
  validate :beginning_must_before_ending_date

  scope :user_id, lambda { |user| where("user_id =?",user) }

  scope :updated_not_null, where("file_updated_at IS NOT NULL")

  def beginning_must_before_ending_date
    errors.add(:base, 'Start date must be before ending date') if self.start_at > self.end_at
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  has_attached_file :file,
    :content_type => ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' , 'text/plain'  ,'application/zip' , 'application/x-rar' ,'application/msword' , 'application/vnd.ms-excel' ],
    :url => ':basename.:extension',
    :path => ':rails_root/tmp/data/note_comments/:basename.:extension '

  validates_attachment_content_type :file, :content_type =>
    ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ,'text/plain' ,'application/zip' , 'application/x-rar',  'application/msword' , 'application/vnd.ms-excel' ]
  validates_attachment_size :file, :less_than => 10.megabytes
end
