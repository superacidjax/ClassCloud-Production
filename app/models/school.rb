class School < ActiveRecord::Base
  has_many :user, :dependent => :destroy
  
  belongs_to :states
end
