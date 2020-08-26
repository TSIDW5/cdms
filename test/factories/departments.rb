FactoryBot.define do
  factory :department do
    name { "Departamento Teste" }
    description { "Descrição padrão" }
    sequence(:initials) { |n| "DP#{n}TESTE" }
    local { "Sala b14 " }
    phone { "(42)-982009090" }
    sequence(:email) { |n| "departamento#{n}@utfpr.edu.br" }
  end
end
