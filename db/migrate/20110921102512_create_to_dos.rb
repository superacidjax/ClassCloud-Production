class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.text :title
      t.text :date
      t.string :user_id
      t.boolean :status

      t.timestamps
    end
  end
end
