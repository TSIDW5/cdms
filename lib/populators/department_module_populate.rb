require_relative 'base_populate'

class Populators::DepartmentModulePopulate < Populators::BasePopulate
  def self.populate(_amount = 30)
    instance.delete
    instance.create
    instance.log(DepartmentModule.count)
  end

  def create
    Department.all.each do |department|
      number_modules.times do
        department.modules.create!(
          name: Faker::Company.unique.name,
          description: Faker::Lorem.sentence(word_count: 100)
        )
      end
    end
  end

  def number_modules
    rand(1..5)
  end
end
