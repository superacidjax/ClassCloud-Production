class AddDescriptionColumnToToDo < ActiveRecord::Migration
  def self.up
    add_column :to_dos, :description, :text
  end

  def self.down
    remove_column :to_dos, :description
  end
end
