FactoryBot.define do
  factory :department_module do
    department { FactoryBot.create(:department) }
    sequence(:name) { |n| "MOdulo#{n}" }
    description { "Descrição padrão de um modulo" }
  end
end


