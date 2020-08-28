require 'application_system_test_case'

class DeleteDepartmentTest < ApplicationSystemTestCase
  context 'logged in' do
    should 'delete Department', js: true do
      admin = create(:admin)
      login_as(admin, scope: :admin)
        
      department = create(:department)

      visit admins_departments_path
      
      find(:css, 'i.fas.fa-trash').click
      page.driver.browser.switch_to.alert.accept
      
      assert_current_path admins_departments_path
      assert_selector('div.alert.alert-success', text: I18n.t('flash.actions.destroy.m', { resource_name: I18n.t('activerecord.models.department.one') }))
    end
  end

  context 'not logged in' do
    should 'redirect to sing_in' do
      
      visit admins_departments_path

      assert_current_path(new_admin_session_path)
    end
  end
end