class AddPhoneToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :phone, :string
  end
end
