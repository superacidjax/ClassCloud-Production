class AddGradeToWriteboard < ActiveRecord::Migration
  def self.up
    add_column :writeboards, :grade, :string, :limit => 3
  end

  def self.down
    remove_column :writeboards, :grade
  end
end
