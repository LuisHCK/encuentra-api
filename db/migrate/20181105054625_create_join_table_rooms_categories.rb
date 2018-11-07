class CreateJoinTableRoomsCategories < ActiveRecord::Migration[5.2]
  def change
    create_join_table :rooms, :categories do |t|
      t.index [:room_id, :category_id]
      # t.index [:category_id, :room_id]
    end
  end
end
