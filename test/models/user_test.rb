require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:register_number)

    context '#username' do
      setup do
        @user = build(:user)
      end

      should validate_uniqueness_of(:username)

      should 'valid format' do
        usernames = %w[username user123]

        usernames.each do |username|
          @user.username = username
          assert @user.valid?, "'#{username}' should be valid"
        end
      end

      should 'invalid format' do
        usernames = ['user name', 'user-123', 'user.name']

        usernames.each do |username|
          @user.username = username
          assert_not @user.valid?, "'#{username}' should be invalid"
        end
      end
    end

    context '#cpf' do
      setup do
        @user = build(:user)
      end

      should 'valid format' do
        cpfs = ['521.399.891-71', '573.574.880-71']

        cpfs.each do |cpf|
          @user.cpf = cpf
          assert @user.valid?, "'#{cpf}' should be valid"
        end
      end

      should 'invalid format' do
        cpfs = ['01234567890', '11111111111', 'aaa.bbb.ccc-dd']

        cpfs.each do |cpf|
          @user.cpf = cpf
          assert_not @user.valid?, "'#{cpf}' should be invalid"
        end
      end
    end
  end

  context '#username to email' do
    setup do
      @user = build(:user)
    end

    should 'build email' do
      @user.username = 'guest'
      assert_equal('guest@utfpr.edu.br', @user.email)
    end
  end
end
