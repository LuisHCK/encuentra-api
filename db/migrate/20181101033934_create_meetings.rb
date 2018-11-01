class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :date_time
      t.string :message
      t.string :state

      t.timestamps
    end
  end
end
