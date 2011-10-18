class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true
  attr_accessible :vote, :voter, :voteable

  after_create :add_voteable_user_id

  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

  def add_voteable_user_id
    user_id = self.voteable_type.constantize.find(self.voteable_id).user_id
    self.update_attribute(:voteable_user_id, user_id)
  end
end