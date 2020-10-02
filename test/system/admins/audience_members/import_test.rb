require 'application_system_test_case'

class ImportTest < ApplicationSystemTestCase
  context 'audience_members' do
    setup do
      admin = create(:admin)
      login_as(admin, scope: :admin)
    end

    should 'valid import file' do
      visit admins_audience_members_import_new_path

      attach_file 'import_file_file', FileHelper.csv.path, make_visible: true
      submit_form("button[type='submit']")

      flash_message = I18n.t('flash.actions.import.m', resource_name: I18n.t('activerecord.models.audience_member.other'))
      assert_selector('div.alert.alert-success', text: flash_message)
    end

    should 'invalid import file' do
      visit admins_audience_members_import_new_path

      submit_form("button[type='submit']")

      assert_selector('div.alert.alert-danger', text: I18n.t('views.audience_member.import.extension_invalid'))      
      assert_selector('div.alert.alert-danger', text: I18n.t('errors.messages.blank'))      
    end

    should 'invalid extension import file' do
      visit admins_audience_members_import_new_path

      attach_file 'import_file_file', FileHelper.image.path, make_visible: true
      submit_form("button[type='submit']")

      assert_selector('div.alert.alert-danger', text: I18n.t('views.audience_member.import.extension_invalid'))      
    end

    should 'teste' do
      visit admins_audience_members_import_new_path

      attach_file 'import_file_file', FileHelper.csv.path, make_visible: true
      submit_form("button[type='submit']")

      flash_message = I18n.t('flash.actions.import.m', resource_name: I18n.t('activerecord.models.audience_member.other'))
      assert_selector('div.alert.alert-success', text: flash_message)

      attach_file 'import_file_file', FileHelper.csv.path, make_visible: true
      submit_form("button[type='submit']")

      assert_selector('div.card-body', text: "Email já está em uso")
      assert_selector('div.card-body', text: "CPF já está em uso")
            
    end    
  end
end
