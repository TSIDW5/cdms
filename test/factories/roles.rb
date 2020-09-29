FactoryBot.define do
  factory :role do
    name { 'Role name' }

    trait :manager do
      identifier { 'manager' }
    end

    trait :assistant do
      identifier { 'assistant' }
    end

    factory :role_manager, traits: [:manager]
    factory :role_assistant, traits: [:assistant]

    to_create do |instance|
      instance.attributes = Role.find_or_create_by(name: instance.name,
                                                   identifier: instance.identifier).attributes
      instance.instance_variable_set('@new_record', false)
    end
  end
end
