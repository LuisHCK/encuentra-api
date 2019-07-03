class ChatSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :user
  has_one :room
end
