module Populaters
  class UserPopulate
    def self.insert(amount = 0)
      amount.times do
        first_name = Faker::Name.unique.first_name
        last_name = Faker::Name.unique.last_name
        name = "#{first_name} #{last_name}"
        username = "#{first_name.downcase.sub(' ', '')}#{last_name.downcase.sub(' ', '')}".gsub(/\W/, '')

        User.create!(
          name: name,
          register_number: Faker::Number.number(digits: 7),
          cpf: CPF.generate,
          active: rand(0..1) == 1,
          username: username
        )

        puts "Inserted '#{username}'"
      end
    end
  end
end
