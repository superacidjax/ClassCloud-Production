class City < ActiveRecord::Base
  has_many :schools, :dependent => :destroy

  belongs_to :states
end
