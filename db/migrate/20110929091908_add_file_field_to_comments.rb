class AddFileFieldToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :file_file_name,    :string
    add_column :comments, :file_content_type, :string
    add_column :comments, :file_file_size,    :integer
    add_column :comments, :file_updated_at,   :datetime
    add_column :comments, :class_room_id,   :integer
    remove_column :upload_files, :class_room_id

  end

  def self.down
    remove_column :comments, :file_file_name
    remove_column :comments, :file_content_type
    remove_column :comments, :file_file_size
    remove_column :comments, :file_updated_at
    remove_column :comments, :class_room_id
  end
end
