class AddIsPublicColumnToWriteboard < ActiveRecord::Migration
  def change
    add_column :writeboards, :is_public, :boolean
  end
end
