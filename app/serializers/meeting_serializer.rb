class MeetingSerializer < ActiveModel::Serializer
  attributes :id, :date_time, :message, :state, :created_at, :updated_at
  belongs_to :user
  belongs_to :room
end
