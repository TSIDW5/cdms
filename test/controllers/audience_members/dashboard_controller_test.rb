require 'test_helper'

class AudienceMembers::DashboardControllerTest < ActionDispatch::IntegrationTest
  context 'not logged in' do
    should 'redirect to sing_in' do
      get audience_members_root_url
      assert_response :redirect
      assert_redirected_to new_audience_member_session_url
    end
  end

  context 'logged in' do
    should 'get audience_member dashboard' do
      sign_in create(:audience_member)

      get audience_members_root_url
      assert_response :success
      assert_breadcrumbs({ text: I18n.t('views.breadcrumbs.home') })
      assert_active_link(href: audience_members_root_path)
    end
  end
end
