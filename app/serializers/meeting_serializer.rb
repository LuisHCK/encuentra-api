class MeetingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date_time, :message, :created_at

  belongs_to :room
  belongs_to :user
end
