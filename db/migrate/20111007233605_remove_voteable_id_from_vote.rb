class RemoveVoteableIdFromVote < ActiveRecord::Migration
  def up
    remove_column :votes,:voteable_id
    add_column :votes, :voteable_id, :integer
  end

  def down
  end
end
