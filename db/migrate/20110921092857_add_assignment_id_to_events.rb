class AddAssignmentIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :assignment_id, :integer
    add_index :events, :assignment_id
  end
end
