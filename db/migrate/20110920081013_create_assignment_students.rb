class CreateAssignmentStudents < ActiveRecord::Migration
  def change
    create_table :assignment_students do |t|
      t.integer :assignment_id
      t.integer :user_id

      t.timestamps
    end
    add_index :assignment_students, :assignment_id
    add_index :assignment_students, :user_id
  end
end
