module Populaters
  class AudienceMemberPopulate
    def self.insert(amount = 0)
      amount.times do
        name = Faker::Name.unique.name

        AudienceMember.create!(
          name: name,
          cpf: CPF.generate,
          email: Faker::Internet.unique.email
        )

        puts "Inserted audience member '#{name}'"
      end
    end
  end
end
