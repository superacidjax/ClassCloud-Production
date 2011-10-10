class RemoveFileFromUploadFile < ActiveRecord::Migration
  def up
    remove_column :upload_files, :file
  end

  def down
    add_column :upload_files, :file
  end
end
