FactoryBot.define do
  factory :user do
    name { "User" }
    email { "usarname@email.com" }
    username { "usarname" }
    register_number { "123123" }
    cpf { CPF.generate(true) }
    status { false }
  end
end
