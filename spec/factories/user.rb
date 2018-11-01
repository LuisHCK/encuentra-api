FactoryBot.define do
  factory :user do
    username { "newUser" }
    email { "user@email.com" }
    password { "password01" }
    dni { "1234567890" }
    name { "faker" }
    lastname { "user" }
  end

  factory :admin, class: "User" do
    username { "admin" }
    email { "admin@email.com" }
    password { "password01" }
    dni { "1234567890" }
    name { "Administrator" }
    lastname { "User" }
    after(:create) { |user| user.add_role(:admin) }
  end
end
