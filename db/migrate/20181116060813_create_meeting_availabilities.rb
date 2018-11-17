class CreateMeetingAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_availabilities do |t|
      t.date :date_from
      t.date :date_to
      t.time :time_from
      t.time :time_to
      t.boolean :skip_weekends
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
