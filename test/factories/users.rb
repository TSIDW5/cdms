FactoryBot.define do
  factory :user do
    name { 'Name' }
    register_number { '123123' }
    sequence(:username) { |n| "usarname#{n}" }
    cpf { CPF.generate(true) }
    active { false }
  end

  trait :manager do
    role { create(:role_manager) }
  end

  trait :assistant do
    role { create(:role_assistant) }
  end
end
