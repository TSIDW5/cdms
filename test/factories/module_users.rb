FactoryBot.define do
  factory :module_user do
    department_module
    user
    role { :collaborator }
  end
end
