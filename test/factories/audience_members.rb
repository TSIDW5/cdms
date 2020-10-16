FactoryBot.define do
  factory :audience_member do
    name { 'Membro aaaa' }
    sequence(:email) { |n| "member#{n}@utfpr.edu.br" }
    cpf { CPF.generate(true) }
  end
end
