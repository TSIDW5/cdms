require 'test_helper'

class ModuleUserTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:module_user) }

  context 'validations' do
    should validate_presence_of(:user)
    should validate_presence_of(:role)
    should validate_presence_of(:department_module)

    should 'validate duplicated responsible' do
      user = FactoryBot.create(:user)
      module_user = ModuleUser.new(user: user, department_module: subject.department_module, role: :responsible)
      assert module_user.save

      user2 = FactoryBot.create(:user)
      module_user1 = ModuleUser.new(user: user2, department_module: subject.department_module, role: :responsible)

      assert_not module_user1.valid?
    end

    context 'scope' do
      should 'by_module' do
        assert_equal(1, ModuleUser.by_module(subject.department_module).count)

        FactoryBot.create(:module_user, department_module: subject.department_module)
        FactoryBot.create(:module_user, department_module: subject.department_module)

        assert_equal(3, ModuleUser.by_module(subject.department_module).count)
      end

      should 'collaborators by module' do
        assert_equal(1, ModuleUser.collaborators_by_module(subject.department_module).count)

        FactoryBot.create(:module_user, department_module: subject.department_module)
        FactoryBot.create(:module_user, department_module: subject.department_module)

        assert_equal(3, ModuleUser.collaborators_by_module(subject.department_module).count)
      end

      should 'responsible by module' do
        assert_equal(0, ModuleUser.responsible_by_module(subject.department_module).count)
        FactoryBot.create(:module_user, department_module: subject.department_module, role: :responsible)
        assert_equal(1, ModuleUser.responsible_by_module(subject.department_module).count)
      end

      should 'by user and module' do
        assert_equal(1, ModuleUser.by_user_and_module(subject.user, subject.department_module).count)
      end
    end
  end
end
