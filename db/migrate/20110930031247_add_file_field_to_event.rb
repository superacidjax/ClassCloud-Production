class AddFileFieldToEvent < ActiveRecord::Migration
   def self.up
    add_column :events, :file_file_name,    :string
    add_column :events, :file_content_type, :string
    add_column :events, :file_file_size,    :integer
    add_column :events, :file_updated_at,   :datetime

  end

  def self.down
    remove_column :events, :file_file_name
    remove_column :events, :file_content_type
    remove_column :events, :file_file_size
    remove_column :events, :file_updated_at
  end
end
