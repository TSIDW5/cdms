require 'test_helper'

class Admins::DepartmentsControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      @department = create(:department)
      sign_in create(:admin)
    end

    teardown do
      assert_active_link(href: admins_departments_path)
    end

    should 'get index' do
      get admins_departments_path
      assert_response :success
    end

    should 'get new' do
      get new_admins_department_path
      assert_response :success
    end

    should 'get show' do
      get admins_department_path(@department)
      assert_response :success
    end

    should 'get edit' do
      get edit_admins_department_path(@department)
      assert_response :success
    end

    context '#create' do
      should 'successfully' do
        assert_difference('Department.count', 1) do
          post admins_departments_path, params: { department: attributes_for(:department) }
        end
        assert_redirected_to admins_departments_path
        assert_equal I18n.t('flash.actions.create.m', resource_name: Department.model_name.human),
                     flash[:success]
        follow_redirect!
      end

      should 'unsuccessfully' do
        assert_no_difference('Department.count') do
          post admins_departments_path, params: { department: attributes_for(:department, name: '') }
        end

        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]
      end
    end

    context '#update' do
      should 'successfully' do
        patch admins_department_path(@department), params: { department: { name: 'updated' } }
        assert_redirected_to admins_departments_path
        assert_equal I18n.t('flash.actions.update.m', resource_name: Department.model_name.human),
                     flash[:success]
        @department.reload
        assert_equal 'updated', @department.name
        follow_redirect!
      end

      should 'unsuccessfully' do
        patch admins_department_path(@department), params: { department: { name: '' } }
        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]

        name = @department.name
        @department.reload
        assert_equal name, @department.name
      end
    end

    should 'destroy' do
      assert_difference('Department.count', -1) do
        delete admins_department_path(@department)
      end

      assert_redirected_to admins_departments_path
      follow_redirect!
    end
  end

  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [admins_departments_path, new_admins_department_path,
              edit_admins_department_path(1), admins_department_path(1)],
        post: [admins_departments_path],
        patch: [admins_department_path(1)],
        delete: [admins_department_path(1)]
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
