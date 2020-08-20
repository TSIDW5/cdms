require 'application_system_test_case'

class CreateAudienceMemberTest < ApplicationSystemTestCase
  context 'when user is authenticated' do
    should 'create with success when the data are valid' do
      admin = create(:admin)
      login_as(admin, scope: :admin)
      visit new_admins_audience_member_path
      new_email = 'email@email.com'
      new_name = 'new name'
      new_cpf = '086.571.690-02'
      fill_in 'audience_member_name', with: new_name
      fill_in 'audience_member_email', with: new_email
      fill_in 'audience_member_cpf', with: new_cpf
      click_on t('simple_form.buttons.save')
      assert_current_path admins_audience_members_path
      assert_selector(
        'div.alert.alert-success',
        text: t('flash.actions.create.m', { resource_name: t('activerecord.models.audience_member.one') })
      )
      assert_text new_email
      assert_text new_cpf
      assert_text new_name
    end

    should 'not create when the data are invalid' do
      admin = create(:admin)
      login_as(admin, scope: :admin)
      visit new_admins_audience_member_path
      click_on t('simple_form.buttons.save')
      within('div.audience_member_name') do
        assert_text(t('errors.messages.blank'))
      end
      within('div.audience_member_email') do
        assert_text(t('errors.messages.blank'))
        assert_text(t('activerecord.errors.models.audience_member.attributes.email.bad_email'))
      end
      within('div.audience_member_email') do
        assert_text(t('errors.messages.blank'))
        assert_text(t('activerecord.errors.models.audience_member.attributes.cpf.bad_cpf'))
      end
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_audience_members_path
      assert_current_path new_admin_session_path
    end
  end
end
