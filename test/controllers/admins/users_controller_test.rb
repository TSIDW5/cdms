require 'test_helper'

class Admins::UsersControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      @user = create(:user)
      sign_in create(:admin)
    end

    should 'get index' do
      get admins_users_path
      assert_response :success
    end

    should 'get new' do
      get new_admins_user_path
      assert_response :success
    end

    should 'get show' do
      get admins_user_path(@user)
      assert_response :success
    end

    should 'get edit' do
      get edit_admins_user_path(@user)
      assert_response :success
    end

    context '#create' do
      should 'successfully' do
        assert_difference('User.count', 1) do
          post admins_users_path, params: { user: attributes_for(:user) }
        end
        assert_redirected_to admins_users_path
        assert_equal I18n.t('flash.actions.create.m', resource_name: User.model_name.human),
                     flash[:success]
      end

      should 'unsuccessfully' do
        assert_no_difference('User.count') do
          post admins_users_path, params: { user: attributes_for(:user, username: '') }
        end

        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]
      end
    end

    context '#update' do
      should 'successfully' do
        patch admins_user_path(@user), params: { user: { name: 'updated' } }
        assert_redirected_to admins_users_path
        assert_equal I18n.t('flash.actions.update.m', resource_name: User.model_name.human),
                     flash[:success]
        @user.reload
        assert_equal 'updated', @user.name
      end

      should 'unsuccessfully' do
        patch admins_user_path(@user), params: { user: { name: '' } }
        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]

        name = @user.name
        @user.reload
        assert_equal name, @user.name
      end
    end

    should 'destroy' do
      assert_difference('User.count', -1) do
        delete admins_user_path(@user)
      end

      assert_redirected_to admins_users_path
    end
  end

  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [admins_users_path, admins_users_path,
              edit_admins_user_path(1), admins_user_path(1)],
        post: [admins_users_path],
        patch: [admins_user_path(1)],
        delete: [admins_user_path(1)]
      }

      requests.each do |method, routes|
        routes.each do |route|
          send(method, route)
          assert_redirected_to new_admin_session_path
        end
      end
    end
  end

  context 'add breadcrumbs' do
    should 'have index users path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.users'), admins_users_path)
      assert_equal "/admins/users", element.path
      assert_equal "Usuários", element.name
    end 

    should 'have new user path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.new'), new_admins_user_path)
      assert_equal "/admins/users/new", element.path
      assert_equal "Novo", element.name
    end 

    should 'have show user path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.user')+" #1", admins_user_path(1))
      assert_equal "/admins/users/1", element.path
      assert_equal "Usuário #1", element.name
    end

    should 'have edit user path' do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.edit'), edit_admins_user_path(1))
      assert_equal "/admins/users/1/edit", element.path
      assert_equal "Editar", element.name
    end
  end
end
