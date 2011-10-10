class ModifiedAddIsPublicToAssignment < ActiveRecord::Migration
  def up
    remove_column :assignments, :is_public
    add_column :assignments, :is_public, :boolean, :default =>false
  end

  def down
  end
end
