FactoryBot.define do
  factory :meeting do
    user
    room
    date_time { Time.now + 1.hour }
    message { "lorem ipsum text" }
  end
end
