class RemoveCommentFieldOnComments < ActiveRecord::Migration
  def up
    add_column :upload_files, :class_room_id,   :integer
    remove_column :upload_files, :comment_id
  end

  def down
  end
end
