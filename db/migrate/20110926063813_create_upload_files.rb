class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.text :title
      t.string :file
      t.string :user_id

      t.timestamps
    end
  end
end
