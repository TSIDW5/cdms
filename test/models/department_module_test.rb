require 'test_helper'

class DepartmentModuleTest < ActiveSupport::TestCase
  subject { FactoryBot.build(:department_module) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:description)

    should validate_uniqueness_of(:name)
  end
end
