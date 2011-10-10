class AddFileFieldToMessageFile < ActiveRecord::Migration
  def self.up
    add_column :message_files, :file_file_name,    :string
    add_column :message_files, :file_content_type, :string
    add_column :message_files, :file_file_size,    :integer
    add_column :message_files, :file_updated_at,   :datetime
    add_column :message_files, :class_room_id,   :integer
    remove_column :message_files, :user_id
    add_column :message_files, :user_id,   :integer

  end

  def self.down
    remove_column :message_files, :file_file_name
    remove_column :message_files, :file_content_type
    remove_column :message_files, :file_file_size
    remove_column :message_files, :file_updated_at
    remove_column :message_files, :class_room_id
  end
end
