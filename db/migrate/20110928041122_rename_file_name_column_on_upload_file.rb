class RenameFileNameColumnOnUploadFile < ActiveRecord::Migration
  def up
    rename_column :upload_files, :file_name,    :file_file_name
  end

  def down
    remove_column :upload_files, :file_file_name
  end
end
