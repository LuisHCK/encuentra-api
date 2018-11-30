class AddIconToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :icon, :string
  end
end
