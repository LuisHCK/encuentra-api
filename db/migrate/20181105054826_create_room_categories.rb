class CreateRoomCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :room_categories do |t|

      t.timestamps
    end
  end
end
