require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  context 'department module' do
    setup do
      admin = create(:admin)
      login_as(admin, scope: :admin)

      @module = create(:department_module)
      @department = @module.department
      @user = create(:user)
      visit admins_department_module_users_list_path(@department, @module)
    end

    should 'add new collaborator' do
      fill_in 'user_search', with: @user.name
      find('[data-user-option]').click
      find('.submit-search').click
      base_selector = 'tr:nth-child(1)'

      assert_selector base_selector, text: @user.name
      assert_selector base_selector, text: @user.email
      assert_current_path admins_department_module_users_list_path(@department, @module)
    end

    should 'add new responsible' do
      fill_in 'user_search', with: @user.name
      find('[data-user-option]').click
      find('#user_type option', text: I18n.t('activerecord.attributes.department_module.responsible')).select_option
      find('.submit-search').click

      base_selector = 'tr:nth-child(1)'

      assert_current_path admins_department_module_users_list_path(@department, @module)
      assert_selector base_selector, text: @user.name
      assert_selector base_selector, text: @user.email
      assert_selector base_selector, text: I18n.t('activerecord.attributes.department_module.responsible')
    end

    should 'responsible duplicated error' do
      fill_in 'user_search', with: @user.name
      find('[data-user-option]').click
      find('#user_type option', text: I18n.t('activerecord.attributes.department_module.responsible')).select_option
      find('.submit-search').click

      base_selector = 'tr:nth-child(1)'

      assert_current_path admins_department_module_users_list_path(@department, @module)
      assert_selector base_selector, text: @user.name
      assert_selector base_selector, text: @user.email
      assert_selector base_selector, text: I18n.t('activerecord.attributes.department_module.responsible')

      user2 = create(:user)

      fill_in 'user_search', with: user2.name
      find('[data-user-option]').click
      find('#user_type option', text: I18n.t('activerecord.attributes.department_module.responsible')).select_option
      find('.submit-search').click

      accept_alert(I18n.t('activerecord.models.department_module.duplicated_responsible'))

      assert_current_path admins_department_module_users_list_path(@department, @module)
    end

    should 'delete module user' do
      fill_in 'user_search', with: @user.name
      find('[data-user-option]').click
      find('.submit-search').click

      within('#main-content table.table tbody') do
        accept_confirm do
          find("a[href='#{admins_department_module_users_destroy_path(@department, @module, @user)}']").click
        end
      end

      flash_message = I18n.t('activerecord.models.user.one')
      assert_selector('div.alert.alert-success',
                      text: I18n.t('flash.actions.destroy.m', resource_name: flash_message))

      within('table.table tbody') do
        refute_text @user.name
        refute_text @user.email
      end
    end
  end
end
