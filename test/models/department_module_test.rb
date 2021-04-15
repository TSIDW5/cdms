require 'test_helper'

class DepartmentModuleTest < ActiveSupport::TestCase
  subject { FactoryBot.build(:department_module) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:description)

    should validate_uniqueness_of(:name)
  end

  context 'members' do
    setup do
      @dmodule = create(:department_module)
    end

    should '#search_non_members' do
      user1 = create(:user, name: "usuario 1")
      user2 = create(:user, name: "usuario 2")
      
      create(:department_module_user, :collaborator,
                                       department_module: @dmodule, user: user1)
      
      response = @dmodule.search_non_members('u')

      assert_equal([user2], response)
    end

    should '#search_non_members_with_accent' do
      user_joao = create(:user, name: 'João')
      user_joao_with_accent = create(:user, name: 'Joao')

      response = @dmodule.search_non_members('joao')

      assert_contains(response, user_joao)
      assert_contains(response, user_joao_with_accent)
    end

    should '#search_non_members_order_ascii' do
      user_1 = create(:user, name: 'Aab')
      user_2 = create(:user, name: 'Abc')
      user_3 = create(:user, name: 'Baa')

      response = @dmodule.search_non_members('a')

      assert_equal(user_1, response[0])
      assert_equal(user_2, response[1])
      assert_equal(user_3, response[2])
    end
  end

end
