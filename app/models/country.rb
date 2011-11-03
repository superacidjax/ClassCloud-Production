class Country < ActiveRecord::Base
  has_many :states,:dependent =>:destroy
  has_many :cities,:dependent =>:destroy
  
  scope :search_by_country, lambda {|name| {:conditions => ["lower(name) LIKE ?","%"+name.downcase+"%"]} }

  def self.json_form
    results = []

    self.all.each do |list|
      results << {:name => list.name}
    end

    return results
  end
end
