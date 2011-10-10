class RemoveVoterStringFromVote < ActiveRecord::Migration
  def up
    remove_column :votes,:voteable_type
    remove_column :votes,:voter_string
    add_column :votes, :voter_type, :string
    add_column :votes, :voteable_type, :string
  end

  def down
  end
end
