class AddVersionToWriteboard < ActiveRecord::Migration
  def change
    add_column :writeboards, :version, :string ,:default =>'1'
  end
end
