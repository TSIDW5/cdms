require 'application_system_test_case'

class ListAudienceMembersTest < ApplicationSystemTestCase
  context 'when user is authenticated' do
    should 'list audience members' do
      admin = create(:admin)
      audience_member = create(:audience_member)
      login_as(admin, scope: :admin)
      visit admins_audience_members_path
      assert_current_path admins_audience_members_path
      assert_selector('h1.page-title', text: I18n.t('activerecord.models.audience_member.other'))
      assert_text audience_member.email
      assert_text audience_member.cpf
      assert_text audience_member.name
    end

    should 'delete audience member' do
      admin = create(:admin)
      audience_member = create(:audience_member)
      login_as(admin, scope: :admin)
      visit admins_audience_members_path
      assert_current_path admins_audience_members_path
      assert_selector('h1.page-title', text: I18n.t('activerecord.models.audience_member.other'))
      assert_text audience_member.email
      assert_text audience_member.cpf
      assert_text audience_member.name

      find(:css, 'i.fe.fe-trash-2').click
      confirm_dialog = page.driver.browser.switch_to.alert
      confirm_dialog.accept
      assert_current_path admins_list_audience_members_path
      assert_selector(
        'div.alert.alert-success',
        text: t('flash.actions.destroy.m', { resource_name: t('activerecord.models.audience_member.one') })
      )
      assert_no_text audience_member.email
      assert_no_text audience_member.cpf
      assert_no_text audience_member.name
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_audience_members_path
      assert_current_path new_admin_session_path
    end
  end
end
