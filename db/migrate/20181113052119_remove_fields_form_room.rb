class RemoveFieldsFormRoom < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :services
    remove_column :rooms, :days_available
    remove_column :rooms, :hours_available
    remove_column :rooms, :phones
  end
end
