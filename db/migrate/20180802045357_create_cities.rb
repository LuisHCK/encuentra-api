class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.column :name, :string, :size => 80, :null => false, :unique => true
      t.column :iso, :string, :size => 5, :null => false, :unique => true
      t.references :country, foreign_key: true
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6
      t.timestamps
    end
    add_index :cities, :name
  end
end
