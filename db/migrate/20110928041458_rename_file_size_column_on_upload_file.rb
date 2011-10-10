class RenameFileSizeColumnOnUploadFile < ActiveRecord::Migration
   def up
    rename_column :upload_files, :file_size, :file_file_size
  end

  def down
    remove_column :upload_files, :file_file_size
  end
end
