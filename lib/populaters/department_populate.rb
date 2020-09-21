module Populaters
  class DepartmentPopulate
    def self.insert(amount = 0)
      amount.times do |index|
        name = Faker::Lorem.unique.word
        initials = "#{name[0]}#{name[1]}#{name[2]}#{name[3]}#{name[4]}#{index}"

        Department.create!(
          name: name,
          description: Faker::Lorem.sentence(word_count: 100),
          initials: initials,
          local: Faker::Address.city,
          email: Faker::Internet.unique.email,
          phone: "#{Faker::Number.between(from: 1, to: 9)}#{Faker::Number.between(from: 1, to: 9)}9#{Faker::Number.number(digits: 8)}"
        )

        puts "Inserted department '#{name}'"
      end
    end
  end
end
