class RemoveFileFieldFromMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :file_file_name
    remove_column :messages, :file_file_size
    remove_column :messages, :file_content_type
    remove_column :messages, :file_updated_at


  end

  def down
    remove_column :messages, :file_file_name
    remove_column :messages, :file_file_size
    remove_column :messages, :file_content_type
    remove_column :messages, :file_updated_at

  end
end
