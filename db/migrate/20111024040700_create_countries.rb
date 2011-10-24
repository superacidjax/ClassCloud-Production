class CreateCountries < ActiveRecord::Migration
  def change
    remove_column :states, :country
    add_column :states, :country_id, :integer
    create_table :countries do |t|
      t.string :name
      t.timestamps
    end
  end
end
