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
        valid_phones = %w[42999034056 42999034213]
        valid_phones.each do |valid_phone|
          subject.phone = valid_phone
          assert subject.valid?
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
end
