class CreateMessageFiles < ActiveRecord::Migration
  def change
    create_table :message_files do |t|
      t.text :title
      t.string :file
      t.string :user_id
      t.timestamps
    end
  end
end
