require 'test_helper'

class Admins::DashboardControllerTest < ActionDispatch::IntegrationTest
  context 'not logged in' do
    should 'redirect to sing_in' do
      get admins_root_url
      assert_response :redirect
      assert_redirected_to new_admin_session_url
    end
  end

  context 'logged in' do
    should 'get admin dashboard' do
      sign_in create(:admin)

      get admins_root_url
      assert_response :success
    end
  end

  
end
