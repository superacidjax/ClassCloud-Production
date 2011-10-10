class CreateWriteboards < ActiveRecord::Migration
  def change
    create_table :writeboards do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :assignment_id

      t.timestamps
    end
    add_index :writeboards, :user_id
    add_index :writeboards, :assignment_id
  end
end
