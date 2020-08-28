require 'application_system_test_case'

class CreateDepartmentTest < ApplicationSystemTestCase
  context 'logged in' do
    should 'creating department' do
        
        admin = create(:admin)
        login_as(admin, scope: :admin)
        
        visit new_admins_department_url

        new_name = 'Nome departamento'       
        new_initials = 'DP1'
        new_phone = '42-090909090'
        new_local = 'sala B12'
        new_email = 'departamento@utfpr.edu.br'
        new_description = 'Descrição'
        
        fill_in 'department_name', with: new_name
        fill_in 'department_initials', with: new_initials
        fill_in 'department_phone', with: new_phone
        fill_in 'department_local', with: new_local
        fill_in 'department_email', with: new_email
        fill_in 'department_description', with: new_description
  
        click_on I18n.t('simple_form.buttons.save')
  
        assert_current_path admins_departments_path
        
        assert_selector(
          'div.alert.alert-success',
          text: I18n.t('flash.actions.create.m', { resource_name: I18n.t('activerecord.models.department.one') })
        )
    end  

    should 'error creating department' do

      admin = create(:admin)
      login_as(admin, scope: :admin)

      visit new_admins_department_url
      
      new_name = ''       
      new_initials = ''
      new_phone = ''
      new_local = ''
      new_email = ''
      new_description = ''

      fill_in 'department_name', with: new_name
      fill_in 'department_initials', with: new_initials
      fill_in 'department_phone', with: new_phone
      fill_in 'department_local', with: new_local
      fill_in 'department_email', with: new_email
      fill_in 'department_description', with: new_description

      click_on I18n.t('simple_form.buttons.save')

      within('div.department_name') do
        assert_text(I18n.t('errors.messages.blank'))
      end

      within('div.department_initials') do
        assert_text(I18n.t('errors.messages.blank'))
      end

      within('div.department_email') do
        assert_text(I18n.t('errors.messages.blank'))
      end

      within('div.department_local') do
        assert_text(I18n.t('errors.messages.blank'))
      end
    end    
  end
end