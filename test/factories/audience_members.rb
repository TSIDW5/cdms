FactoryBot.define do
  factory :audience_member do
    sequence(:name) { |n| "Member #{n}" }
    sequence(:email) { |n| "member#{n}@utfpr.edu.br" }
    cpf { CPF.generate(true) }
  end
end
