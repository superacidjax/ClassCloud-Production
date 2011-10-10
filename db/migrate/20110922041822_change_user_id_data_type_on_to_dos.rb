class ChangeUserIdDataTypeOnToDos < ActiveRecord::Migration
  def up
    remove_column :to_dos, :user_id
    add_column :to_dos, :user_id, :integer
  end

  def down
    remove_column :to_dos, :user_id
    add_column :to_dos, :user_id, :string
  end
end
