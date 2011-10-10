class RenameCategoryIdFieldOnAssignment < ActiveRecord::Migration
  def up
    rename_column :assignments, :category_id, :assignment_category_id
  end

  def down
    rename_column :assignments, :assignment_category_id, :category_id
  end
end
