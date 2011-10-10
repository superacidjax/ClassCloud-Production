class ChangeUserIdDataTypeOnUploadFiles < ActiveRecord::Migration
  def up
    remove_column :upload_files, :user_id
    add_column :upload_files, :user_id, :integer
    add_index :upload_files, :user_id
  end

  def down
    remove_column :upload_files, :user_id
    add_column :upload_files, :user_id, :string
  end
end
