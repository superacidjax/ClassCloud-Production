class AddLastEditedToWriteboard < ActiveRecord::Migration
  def change
    add_column :writeboards, :edited_by_teacher, :boolean ,:default =>false
  end
end
