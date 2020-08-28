require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  subject { FactoryBot.create(:department) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:initials)
    should validate_presence_of(:phone)
    should validate_presence_of(:local)
    should validate_presence_of(:email)
    
    should validate_uniqueness_of(:initials)
    should validate_uniqueness_of(:email)
  end
  context 'Email regex' do
    should 'valid' do
      valid_emails = ['teste@utfpr.edu.br','teste@gmail.com']
      valid_emails.each do |valid_email|
        department = FactoryBot.build(:department, email: valid_email)
        assert department.valid?
      end
    end
    should 'invalid' do
      valid_emails = ['teste@','teste@gmail']
      valid_emails.each do |valid_email|
        department = FactoryBot.build(:department, email: valid_email)
        assert department.invalid?
      end
    end
  end
  context 'phone regex' do
    should 'valid' do
      valid_phones = ['42999034056', '42999034213']
      valid_phones.each do |valid_phone|
        department = FactoryBot.build(:department, phone: valid_phone)
        assert department.valid?
      end
    end
    should 'invalid' do
      valid_phones = ['123123asdsa', 'asdasdasds']
      valid_phones.each do |valid_phone|
        department = FactoryBot.build(:department, phone: valid_phone)
        assert department.invalid?
      end
    end
  end
end
