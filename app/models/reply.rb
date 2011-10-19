class Reply < ActiveRecord::Base
  has_many :user,:dependent => :destroy

  belongs_to :comments
end
