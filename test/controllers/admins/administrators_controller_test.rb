require 'test_helper'

class Admins::AdministratorsControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      sign_in create(:admin)
    end

    should 'get index' do
      get admins_administrators_path
      assert_response :success
      assert_active_link(href: admins_administrators_path)
    end

    context '#create' do
      should 'successfully' do
        user = FactoryBot.create(:user)
        role = FactoryBot.create(:role_manager)

        params = { user: user.name, user_id: user.id, role_id: role.id }
        post admins_administrators_path, params: { administrator: params }

        user.reload
        assert user.is?(:admin)
        assert user.is?(:manager)
        assert_redirected_to admins_administrators_path
        assert_equal I18n.t('flash.actions.add.m', resource_name: Administrator.model_name.human), flash[:success]
      end

      should 'unsuccessfully' do
        params = { user: '', user_id: '', role_id: '' }
        post admins_administrators_path, params: { administrator: params }

        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]
      end
    end

    should 'destroy' do
      user = FactoryBot.create(:user, :manager)
      delete admins_administrator_path(user)

      user.reload
      assert_not user.is?(:admin)
      assert_not user.is?(:manager)
      assert_redirected_to admins_administrators_path
    end
  end

  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [admins_administrators_path],
        post: [admins_administrators_path],
        delete: [admins_administrator_path(1)]
      }

      requests.each do |method, routes|
        routes.each do |route|
          send(method, route)
          assert_redirected_to new_admin_session_path
        end
      end
    end
  end
end
