FactoryBot.define do
  factory :department_user do
    department
    user

    traits_for_enum(:role, DepartmentUser.roles.values)
  end
end
