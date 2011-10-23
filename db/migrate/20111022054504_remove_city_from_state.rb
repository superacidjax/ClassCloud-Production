class RemoveCityFromState < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name
      t.string :state_id
      t.timestamps
    end
    remove_column :states, :city
  end

  def down
  end
end
