require_relative 'base_populate'

class Populators::AudienceMemberPopulate < Populators::BasePopulate
  def create
    AudienceMember.create!(
      name: Faker::Name.unique.name,
      cpf: CPF.generate,
      email: Faker::Internet.unique.email
    )
  end
end
