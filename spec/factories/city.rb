FactoryBot.define do
  factory :city do
    name { "Managua" }
    iso { "MNG" }
    country
    latitude { 1.1 }
    longitude { 1.1 }
  end
end
