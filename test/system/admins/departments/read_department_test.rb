require 'application_system_test_case'

class ReadDepartmentTest < ApplicationSystemTestCase
  
  context 'logged in' do
    should 'view list of departments', js: true do
      admin = create(:admin)
      login_as(admin, scope: :admin)
        
      department = create(:department)
      department1 = create(:department)

      visit admins_departments_path
      
      assert_text department.name
      assert_text department1.name
    end
  end

  context 'not logged in' do
    should 'redirect to sing_in' do
      
      visit admins_departments_url

      assert_current_path(new_admin_session_path)
    end
  end
end