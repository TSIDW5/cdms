require 'application_system_test_case'

class SidebarTest < ApplicationSystemTestCase
  context 'sidebar' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)
    end

    should 'display sidebar' do
      visit admins_root_path

      assert_selector '.list-group-item', text: I18n.t('views.app.sidebar.home_page')
      assert_selector '.list-group-item', text: I18n.t('views.app.sidebar.departments')
      assert_selector '.list-group-item', text: I18n.t('views.app.sidebar.audience_members')
      assert_selector '.list-group-item', text: I18n.t('views.app.sidebar.users')
      assert_selector '.list-group-item', text: I18n.t('views.app.sidebar.administrators')
    end
  end
end
