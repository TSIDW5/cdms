require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:identifier)
    should validate_uniqueness_of(:identifier)
  end

  context 'relationships' do
    should have_many(:users).dependent(:nullify)
  end
end
