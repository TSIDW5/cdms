FactoryBot.define do
  factory :department_module_user do
    department_module
    user

    traits_for_enum(:role, DepartmentModuleUser.roles.values)
  end
end
