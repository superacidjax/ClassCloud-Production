class AddMessageIdToMessageFile < ActiveRecord::Migration
  def self.up
    add_column :message_files, :message_id,    :integer


  end

  def self.down
    remove_column :message_files, :message_id
  end
end
