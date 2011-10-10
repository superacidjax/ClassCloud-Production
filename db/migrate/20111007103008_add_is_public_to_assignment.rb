class AddIsPublicToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :is_public, :boolean
  end
end
