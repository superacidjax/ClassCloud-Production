class MessageFile < ActiveRecord::Base
  has_attached_file :file,
    :content_type => ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' , 'text/plain'  ,'application/zip' , 'application/x-rar' ,'application/msword' , 'application/vnd.ms-excel' ],
    :url => ':basename.:extension',
    :path => ':rails_root/tmp/data/:basename.:extension '
  
  validates_attachment_content_type :file, :content_type =>
    ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ,'text/plain' ,'application/zip' , 'application/x-rar',  'application/msword' , 'application/vnd.ms-excel' ]
  validates_attachment_size :file, :less_than => 10.megabytes
end
