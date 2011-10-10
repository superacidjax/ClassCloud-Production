class RemoveNotNullFromVote < ActiveRecord::Migration
  def up
    remove_column :votes,:voter_id
    remove_column :votes,:voter_type
    add_column :votes, :voter_id, :integer
    add_column :votes, :voter_string, :string
  end

  def down
  end
end
