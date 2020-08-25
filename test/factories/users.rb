FactoryBot.define do
  factory :user do
    name { "User" }
    email { "usarname@email.com" }
    username { "usarname" }
    register_number { "123123" }
    cpf { "123.123.123-12" }
    status { false }
  end
end
