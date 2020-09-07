FactoryBot.define do
  factory :department_user do
    department
    user
    role { :collaborator }
  end
end
