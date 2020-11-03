require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  context 'login as responsible user' do
    setup do
      @department_user = create(:department_user, :responsible)
      login_as(@department_user.user, as: :user)
    end
  end
end