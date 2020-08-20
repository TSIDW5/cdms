require 'test_helper'

class Admins::AudienceMembersControllerTest < ActionDispatch::IntegrationTest
  context 'not logged in' do
    should 'redirect to sing_in' do
      get admins_audience_members_path
      assert_response :redirect
      assert_redirected_to new_admin_session_url
    end
  end

  context 'logged in' do
    should 'get list audience_mamber' do
      sign_in create(:admin)

      get admins_audience_members_path
      assert_response :success
    end
  end
end
