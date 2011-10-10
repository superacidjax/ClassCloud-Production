class RemoveFileColumnOnComments < ActiveRecord::Migration
  def up
    remove_column :comments, :file_file_name
    remove_column :comments, :file_content_type
    remove_column :comments, :file_file_size
    remove_column :comments, :file_updated_at
    remove_column :comments, :class_room_id
    add_column :upload_files, :comment_id,    :integer
    
  end

  def down
    remove_column :upload_files, :comment_id
  end
end
