class AddFieldsToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :services, :string
    add_column :rooms, :days_available, :string
    add_column :rooms, :hours_available, :string
    add_column :rooms, :phones, :string
  end
end
