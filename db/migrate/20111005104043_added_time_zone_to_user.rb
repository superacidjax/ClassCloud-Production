class AddedTimeZoneToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :time_zone
    add_column :users, :time_zone,   :string

  end

  def self.down
    remove_column :users, :time_zone
  end
end
