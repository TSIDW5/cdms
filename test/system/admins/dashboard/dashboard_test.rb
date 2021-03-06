require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  context 'dashboard' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)
    end

    should 'display breadcrumbs' do
      visit admins_root_path

      assert_selector '.breadcrumb-item', text: I18n.t('views.breadcrumbs.home')
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
