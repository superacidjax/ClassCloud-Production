class RemoverFileColumnFromMessageFile < ActiveRecord::Migration
  def up
    remove_column :message_files, :file
    remove_column :message_files, :title

  end

  def down
    remove_column :message_file, :file
    remove_column :message_file, :title

  end
end
