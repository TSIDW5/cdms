FactoryBot.define do
  factory :role do
    trait :manager do
      name { 'Administrator manager' }
      identifier { 'manager' }
    end

    trait :assistant do
      name { 'Administrator assistant' }
      identifier { 'assistant' }
    end

    factory :role_manager, traits: [:manager]
    factory :role_assistant, traits: [:assistant]

    to_create do |instance|
      instance.attributes = Role.create_with(name: instance.name)
                                .find_or_create_by(identifier: instance.identifier).attributes
      instance
    end
  end
end
