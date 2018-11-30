class RemoveMeetingAvailability < ActiveRecord::Migration[5.2]
  def change
    drop_table :meeting_availabilities
  end
end
