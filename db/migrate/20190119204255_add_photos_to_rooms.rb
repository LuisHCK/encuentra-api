class AddPhotosToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :photos, :json
  end
end
