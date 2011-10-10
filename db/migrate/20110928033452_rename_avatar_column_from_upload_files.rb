class RenameAvatarColumnFromUploadFiles < ActiveRecord::Migration
  def self.up
    rename_column :upload_files, :avatar_file_name,    :file_name
    rename_column :upload_files, :avatar_content_type, :file_content_type
    rename_column :upload_files, :avatar_file_size,    :file_size
    rename_column :upload_files, :avatar_updated_at,   :file_updated_at
  end

  def self.down
    remove_column :upload_files, :avatar_file_name
    remove_column :upload_files, :avatar_content_type
    remove_column :upload_files, :avatar_file_size
    remove_column :upload_files, :avatar_updated_at
  end
end
