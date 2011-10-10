class AddClassToUploadFile < ActiveRecord::Migration
  def change
    add_column :upload_files, :class_room_id, :integer
    add_index :upload_files, :class_room_id
  end
end
