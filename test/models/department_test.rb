require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  subject { FactoryBot.build(:department) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:initials)
    should validate_presence_of(:local)

    should validate_uniqueness_of(:initials)
    should validate_uniqueness_of(:email).ignoring_case_sensitivity

    context 'email format' do
      should 'valid' do
        valid_emails = ['teste@utfpr.edu.br', 'teste@gmail.com']
        valid_emails.each do |valid_email|
          subject.email = valid_email
          assert subject.valid?
        end
      end

      should 'invalid' do
        valid_emails = ['teste@', 'teste@gmail']
        valid_emails.each do |valid_email|
          subject.email = valid_email
          assert subject.invalid?
        end
      end
    end

    context 'phone format' do
      should 'valid' do
        valid_phones = ['(42) 99903-4056', '(42) 9903-4213']
        valid_phones.each do |valid_phone|
          subject.phone = valid_phone
          assert subject.valid?, "#{valid_phone} is invalid"
        end
      end

      should 'invalid' do
        valid_phones = %w[123123asdsa asdasdasds]
        valid_phones.each do |valid_phone|
          subject.phone = valid_phone
          assert subject.invalid?
        end
      end
    end
  end

  context 'members' do
    should 'search non members' do
      department = create(:department)
      user_a = create(:user, name: 'user_a')
      user_b = create(:user, name: 'user_b')
      create(:department_user, :collaborator, user: user_a, department: department)

      assert_not_equal [user_a], department.search_non_members('a')
      assert_equal [user_b], department.search_non_members('b')
    end
  end

  context 'search' do
    should 'by name' do
      first_name = 'TSI'
      second_name = 'TMI'

      FactoryBot.create(:department, name: first_name)
      FactoryBot.create(:department, name: second_name)

      assert_equal(1, Department.search(first_name).count)
      assert_equal(1, Department.search(second_name).count)
      assert_equal(2, Department.search('').count)
    end
  end
end
