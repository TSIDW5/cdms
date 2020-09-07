FactoryBot.define do
  factory :department_module do
    department
    sequence(:name) { |n| "Modulo#{n}" }
    description { 'Descrição padrão de um modulo' }
  end
end
