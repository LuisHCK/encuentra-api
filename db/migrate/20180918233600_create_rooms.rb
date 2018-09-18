class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.float :lat
      t.float :lng
      t.string :state

      t.timestamps
    end
  end
end
