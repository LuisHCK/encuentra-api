class MakeCityOptional < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :city_id, :bigint, null: true
  end
end
