class State < ActiveRecord::Base
  has_many :schools, :dependent => :destroy
  has_many :user, :dependent => :destroy
end
