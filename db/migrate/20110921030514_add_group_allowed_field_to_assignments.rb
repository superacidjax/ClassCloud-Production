class AddGroupAllowedFieldToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :group_allowed, :boolean
  end
end
