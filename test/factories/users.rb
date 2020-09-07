FactoryBot.define do
  factory :user do
    name { 'Name' }
    register_number { '123123' }
    sequence(:username) { |n| "usarname#{n}" }
    cpf { CPF.generate(true) }
    active { false }
  end
end
