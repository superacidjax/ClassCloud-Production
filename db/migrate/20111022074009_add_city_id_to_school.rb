class AddCityIdToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :city_id, :integer
  end
end
