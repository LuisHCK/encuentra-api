class AddCurrencyToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :currency, :string
  end
end
