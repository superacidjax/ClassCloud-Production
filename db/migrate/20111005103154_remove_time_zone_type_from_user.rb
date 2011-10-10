class RemoveTimeZoneTypeFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :time_zone
    add_column :users, :time_zone,   :timestamp

  end

  def self.down
    remove_column :users, :time_zone
  end
end
