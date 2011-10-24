class RemoveUniversity < ActiveRecord::Migration
  def up
    drop_table :universities
  end

  def down
  end
end
