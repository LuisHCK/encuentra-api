class AddPromotionToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :promotion, :string
  end
end
