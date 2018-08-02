class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.column :name, :string, :size => 80, :null => false
      t.references :city, foreign_key: true
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6
      t.timestamps
    end
    add_index :zones, :name
  end
end
