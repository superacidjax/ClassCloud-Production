class AddVoteableUserIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :voteable_user_id, :integer
  end
end
