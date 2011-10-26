class School < ActiveRecord::Base
  has_many :user, :dependent => :destroy
  belongs_to :city
  belongs_to :state
end
