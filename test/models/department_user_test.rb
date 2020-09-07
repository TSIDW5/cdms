require 'test_helper'

class DepartmentUserTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:department_user) }

  context 'validations' do
    should validate_presence_of(:user)
    should validate_presence_of(:role)
    should validate_presence_of(:department)

    should 'validate duplicated responsible' do
      user = FactoryBot.create(:user)
      department_user = DepartmentUser.new(user: user, department: subject.department, role: :responsible)
      assert department_user.save

      user2 = FactoryBot.create(:user)
      department_user1 = DepartmentUser.new(user: user2, department: subject.department, role: :responsible)

      assert_not department_user1.valid?
    end

    context 'scope' do
      should 'by department' do
        assert_equal(1, DepartmentUser.by_department(subject.department).count)

        FactoryBot.create(:department_user, department: subject.department)
        FactoryBot.create(:department_user, department: subject.department)

        assert_equal(3, DepartmentUser.by_department(subject.department).count)
      end

      should 'collaborators by department' do
        assert_equal(1, DepartmentUser.collaborators_by_department(subject.department).count)

        FactoryBot.create(:department_user, department: subject.department)
        FactoryBot.create(:department_user, department: subject.department)

        assert_equal(3, DepartmentUser.collaborators_by_department(subject.department).count)
      end

      should 'responsible by department' do
        assert_equal(0, DepartmentUser.responsible_by_department(subject.department).count)
        FactoryBot.create(:department_user, department: subject.department, role: :responsible)
        assert_equal(1, DepartmentUser.responsible_by_department(subject.department).count)
      end

      should 'by user and department' do
        assert_equal(1, DepartmentUser.by_user_and_department(subject.user, subject.department).count)
      end
    end
  end
end
