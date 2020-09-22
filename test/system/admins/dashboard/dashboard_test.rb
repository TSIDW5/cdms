require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  context 'dashboard' do
    setup do
      admin = create(:admin)
      login_as(admin, scope: :admin)
    end

    should 'display breadcrumbs' do
      visit admins_root_path

      assert_selector '.breadcrumb-item', text: I18n.t('views.breadcrumbs.home')
    end
  end
end
