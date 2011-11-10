class UploadFile < ActiveRecord::Base
  belongs_to :user
  
  scope :pdf_category,where("file_content_type=?",COMPRESS_TYPE[0])
  scope :file_name_category,where("file_content_type=? or  file_content_type=?",COMPRESS_TYPE[0] ,COMPRESS_TYPE[1])
  scope :image_category,where("file_content_type=? or  file_content_type=? or  file_content_type=?",IMAGE_TYPE[0] ,IMAGE_TYPE[1],IMAGE_TYPE[2])
  scope :document_category,where("file_content_type=? or  file_content_type=? or  file_content_type=? or  file_content_type=?", DOCUMENT_TYPE[0] ,DOCUMENT_TYPE[1],DOCUMENT_TYPE[2],DOCUMENT_TYPE[3])

  scope :class_room, lambda { |cri| where("class_room_id = ?",cri) }

  scope :file_size_desc, :order =>'file_file_size DESC'
  scope :created_desc, :order =>'created_at DESC'
  
  scope :pdf_category,where("file_content_type = ?",COMPRESS_TYPE[0])
  scope :file_name_category,where("file_content_type = ? OR file_content_type = ?",COMPRESS_TYPE[0] ,COMPRESS_TYPE[1])
  scope :image_category,where("file_content_type = ? OR file_content_type = ? OR file_content_type = ?",IMAGE_TYPE[0] ,IMAGE_TYPE[1],IMAGE_TYPE[2])
  scope :document_category,where("file_content_type = ? OR  file_content_type = ? OR file_content_type = ? OR file_content_type = ?", DOCUMENT_TYPE[0] ,DOCUMENT_TYPE[1],DOCUMENT_TYPE[2],DOCUMENT_TYPE[3])

  has_attached_file :file,
    :url => ':basename.:extension',
    :path => ':rails_root/tmp/data/:basename.:extension '
  validates :title,  :presence => true
  validates_attachment_presence :file
  validates_attachment_size :file, :less_than => 15.megabytes

  acts_as_commentable
 
end
