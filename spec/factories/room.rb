FactoryBot.define do
  factory :room do
    title { "MyString" }
    description { "MyText" }
    price { 1 }
    lat { 1.5 }
    lng { 1.5 }
    user { nil }
    zone { nil }
  end
end