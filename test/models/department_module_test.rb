require 'test_helper'

class DepartmentModuleTest < ActiveSupport::TestCase
  subject { FactoryBot.build(:department_module) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:description)

    should validate_uniqueness_of(:name)
  end

  context 'members' do
    should '#search_non_members' do
      dmodule = create(:department_module)
      user1 = create(:user, name: "usuario 1")
      user2 = create(:user, name: "usuario 2")
      
      create(:department_module_user, :collaborator,
                                       department_module: dmodule, user: user1)
      
      response = dmodule.search_non_members('u')

      assert_equal([user2], response)
      assert_not_equal([user1], response)
    end
  end

end
