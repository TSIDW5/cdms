require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  context 'dashboard' do
    setup do
      user = create(:user)
      login_as(user, as: :user)
    end

    should 'display breadcrumbs' do
      visit users_root_path

      assert_selector '.breadcrumb-item', text: I18n.t('views.breadcrumbs.home')
    end
  end
end
