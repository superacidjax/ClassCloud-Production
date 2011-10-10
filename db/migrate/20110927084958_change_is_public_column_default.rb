class ChangeIsPublicColumnDefault < ActiveRecord::Migration
  def up
    remove_column :writeboards, :is_public
    add_column :writeboards, :is_public, :boolean, :default =>false
  end

  def down
    remove_column :writeboards, :is_public
    add_column :writeboards, :is_public, :boolean, :default =>false
  end
end
