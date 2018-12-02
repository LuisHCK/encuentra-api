FactoryBot.define do
  factory :promotion do
    room { nil }
    user { nil }
    tier { nil }
    price { 10 }
    payment { "padadito" }
    payment_ref { "123456789" }
    start_date { Time.now }
    end_date { Time.now + 2.weeks }
    notes { "Lorem ipsum dolor sit amet,sed diam nonumy eirmod tempor invidunt" }
  end
end
