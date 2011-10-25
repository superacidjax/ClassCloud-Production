class State < ActiveRecord::Base
  has_many :schools, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :cities, :dependent => :destroy
  belongs_to :country

end
