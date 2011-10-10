class Vote < ActiveRecord::Base
<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable

<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

end