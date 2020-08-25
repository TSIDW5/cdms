FactoryBot.define do
  factory :user do
    name { "User" }
    email { "usarname@email.com" }
    username { "usarname" }
    register_number { "123123" }
    cpf { "381.236.990-77" }
    status { false }
  end
end
