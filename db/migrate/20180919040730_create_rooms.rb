class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.float :lat
      t.float :lng
      t.string :state
      t.references :user, foreign_key: true
      t.references :zone, foreign_key: true

      t.timestamps
    end
  end
end
