FactoryBot.define do
  factory :audience_member do
    name { 'Pedro Gonzaga' }
    sequence(:email) { |n| "email#{n}@utfpr.edu.br" }
    cpf { CPF.generate(true) }
  end
end
