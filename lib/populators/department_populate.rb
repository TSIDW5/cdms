require_relative 'base_populate'

class Populators::DepartmentPopulate < Populators::BasePopulate
  def create
    Faker::Config.locale = 'pt-BR'

    Department.create!(
      name: Faker::Company.name,
      initials: Faker::Name.initials(number: 5),
      description: Faker::Lorem.sentence(word_count: 100),
      local: Faker::Address.city,
      email: Faker::Internet.unique.email,
      phone: Faker::PhoneNumber.phone_number
    )
  end
end
