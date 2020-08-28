require 'application_system_test_case'

class CreateUserTest < ApplicationSystemTestCase
  context 'when admin is authenticated' do
    should 'create with success when the data are valid' do
      admin = create(:admin)
      login_as(admin, scope: :admin)
      visit new_admins_user_path
      new_name = 'new name'
      new_cpf = CPF.generate(true)
      new_username = 'username'
      new_register_number = 'register_number'
      fill_in 'user_name', with: new_name
      fill_in 'user_cpf', with: new_cpf
      fill_in 'user_username', with: new_username
      fill_in 'user_register_number', with: new_register_number
      fill_in 'user_active', with: true
      click_on t('simple_form.buttons.save')
      assert_current_path admins_users_path
      assert_selector(
          'div.alert.alert-success',
          text: t('flash.actions.create.m', { resource_name: t('activerecord.models.user.one') })
      )
      assert_text new_cpf
      assert_text new_name
      assert_text new_username
      assert_text new_register_number
    end

    should 'not create when the data are invalid' do
      admin = create(:admin)
      login_as(admin, scope: :admin)
      visit new_admins_user_path
      click_on t('simple_form.buttons.save')
      within('div.user_name') do
        assert_text(t('errors.messages.blank'))
      end
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_users_path
      assert_current_path new_admins_user_path
    end
  end
end
