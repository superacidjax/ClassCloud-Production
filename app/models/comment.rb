class Comment < ActiveRecord::Base
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======

>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  scope :updated_not_null,where("file_updated_at IS NOT NULL")
  scope :commentable_type_note, where("commentable_type =?",COMMENTABLE_TYPE[0])
  scope :commentable_type_discussion, where("commentable_type =?",COMMENTABLE_TYPE[2])
  scope :user_id,lambda{|user|where("user_id =?",user)}
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
  # NOTE: Comments belong to a user
  belongs_to :user
<<<<<<< HEAD
<<<<<<< HEAD
=======
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  validates :comment, :user_id, :presence => true

  has_attached_file :file,
    :content_type => ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' , 'text/plain'  ,'application/zip' , 'application/x-rar' ,'application/msword' , 'application/vnd.ms-excel' ],
    :url => ':basename.:extension',
    :path => ':rails_root/tmp/data/note_comments/:basename.:extension '

  validates_attachment_content_type :file, :content_type =>
    ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ,'text/plain' ,'application/zip' , 'application/x-rar',  'application/msword' , 'application/vnd.ms-excel' ]
  validates_attachment_size :file, :less_than => 10.megabytes
<<<<<<< HEAD
<<<<<<< HEAD
=======
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  acts_as_voteable
end
