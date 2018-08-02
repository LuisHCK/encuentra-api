class AlterColumnsFromCountries < ActiveRecord::Migration[5.2]
  def change
    change_column :countries, :name, :string, :size => 80, null: false, unique: true
    change_column :countries, :iso, :string, :size => 2, null: false, unique: true
    change_column :countries, :iso3, :string, :size => 3, null: false, unique: true
    add_index :countries, :name
  end
end
