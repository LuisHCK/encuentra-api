class AddServicesToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :services, :json
  end
end
