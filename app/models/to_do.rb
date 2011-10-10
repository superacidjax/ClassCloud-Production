class ToDo < ActiveRecord::Base
<<<<<<< HEAD
  default_scope :order =>("date DESC")
  belongs_to :user
  scope :today ,lambda{where("date like ?",Time.now.strftime("%Y-%m-%d")+"%")}
  validates :title, :description,:date, :presence => true
=======
  default_scope :order => ("date DESC")

  belongs_to :user

  scope :today, where("date like ?",Time.now.strftime("%Y-%m-%d")+"%")

  validates :title, :description, :date, :presence => true
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  TIME_TYPE = [
    ["All", "all"],
    ["Today", "today"],
    ["Tomorrow", "tomorrow"],
    ["This Week", "this week"],
    ["Next Week", "next week"],
    ["Later", "later"]
  ]

end
