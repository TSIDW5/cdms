FactoryBot.define do
  factory :audience_member do
    name { 'Membro' }
    sequence(:email) { |n| "member#{n}@utfpr.edu.br" }
    cpf { CPF.generate(true) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
