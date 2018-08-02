class RevertRequiredDni < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :dni, :string, null: true
  end
end
