class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.column :iso, :string, :size => 2
      t.column :name, :string, :size => 80
      t.column :iso3, :string, :size => 3
      t.column :numcode, :integer
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6
      t.timestamps
    end
  end
end
