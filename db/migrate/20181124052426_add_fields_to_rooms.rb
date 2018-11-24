class AddFieldsToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :phones, :json
    add_column :rooms, :meeting_availabilities, :json
  end
end
