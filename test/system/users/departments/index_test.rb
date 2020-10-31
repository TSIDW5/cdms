require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  context 'login as responsible user' do
    setup do
      @department_user = create(:department_user, :responsible)
      login_as(department_user.user)
    end

    should 'list all linked departments' do
      visit users_departments_path
      assert_selector "<th>#{User.human_attribute_name(:role)}<th>"
    end
  end
end