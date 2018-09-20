FactoryBot.define do
  factory :user do
    username { "newUser" }
    email { "user@email.com" }
    password { "password01" }
    dni { "1234567890" }
    name { "faker" }
    lastname { "user" }
  end
end
