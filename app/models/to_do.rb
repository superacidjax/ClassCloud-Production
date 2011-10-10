class ToDo < ActiveRecord::Base
  default_scope :order =>("date DESC")
  belongs_to :user
  scope :today ,lambda{where("date like ?",Time.now.strftime("%Y-%m-%d")+"%")}
  validates :title, :description,:date, :presence => true
  TIME_TYPE = [
    ["All", "all"],
    ["Today", "today"],
    ["Tomorrow", "tomorrow"],
    ["This Week", "this week"],
    ["Next Week", "next week"],
    ["Later", "later"]
  ]

end
