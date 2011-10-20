class AddUniversityAndStateToUser < ActiveRecord::Migration
  def change
    remove_column :schools, :country
    remove_column :schools, :city
    add_column :states, :city, :string
    add_column :states, :country, :string ,:default =>'USA'
    add_column :schools, :state_id, :integer
  end
end
