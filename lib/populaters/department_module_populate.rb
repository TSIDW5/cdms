module Populaters
  class DepartmentModulePopulate
    def self.insert
      Department.all.each do |department|
        rand(1..5).times do
          name = Faker::Lorem.unique.word

          DepartmentModule.create!(
            name: name,
            description: Faker::Lorem.sentence(word_count: 100),
            department: department
          )

          puts "Inserted module '#{name}' on department '#{department.name}'"
        end
      end
    end
  end
end
