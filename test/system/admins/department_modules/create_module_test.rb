require 'application_system_test_case'

class CreateDepartmentModuleTest < ApplicationSystemTestCase
  context 'logged in' do
    should 'creating department module' do
        
        admin = create(:admin)
        login_as(admin, scope: :admin)
        
        department = create(:department)

        visit new_admins_department_department_module_path(department)

        new_name = 'Nome modulo'       
        new_description = 'Teste'
        
        fill_in 'department_module_name', with: new_name
        fill_in 'department_module_description', with: new_description
  
        click_on I18n.t('simple_form.buttons.save')
  
        #assert_current_path admins_department_url(department)
        
        #assert_selector('div.alert.alert-success', text: I18n.t('flash.actions.create.m', { resource_name: I18n.t('activerecord.models.department_module.one') }) )
    end
    
    should 'error department module' do
        
      admin = create(:admin)
      login_as(admin, scope: :admin)
      
      department = create(:department)
      
      visit new_admins_department_department_module_path(department)

      new_name = 'Nome modulo'       
      new_description = 'Teste'
      
      fill_in 'department_module_name', with: new_name
      fill_in 'department_module_description', with: new_description

      click_on I18n.t('simple_form.buttons.save')

      within('div.department_module_name') do
        assert_text(I18n.t('errors.messages.blank'))
      end

      within('div.department_module_description') do
        assert_text(I18n.t('errors.messages.blank'))
      end
    end 
  end
end