class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
    add_index :assignments, [:category_id, :user_id]
  end
end
