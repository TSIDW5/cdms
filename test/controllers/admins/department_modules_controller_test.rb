require 'test_helper'

class Admins::DepartmentModulesControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      @module = create(:department_module)
      @department = @module.department
      sign_in create(:admin)
    end

    should 'get new' do
      get new_admins_department_module_path(@department)
      assert_response :success
    end

    should 'get edit' do
      get edit_admins_department_path(@department, @module)
      assert_response :success
    end

    context '#create' do
      should 'successfully' do
        assert_difference('DepartmentModule.count', 1) do
          post admins_department_modules_path(@department),
               params: { department_module: attributes_for(:department_module) }
        end
        assert_redirected_to admins_department_path(@department)
        assert_equal I18n.t('flash.actions.create.m', resource_name: DepartmentModule.model_name.human),
                     flash[:success]
      end

      should 'unsuccessfully' do
        assert_no_difference('DepartmentModule.count') do
          post admins_department_modules_path(@department),
               params: { department_module: attributes_for(:department_module, name: '') }
        end

        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]
      end
    end

    context '#update' do
      should 'successfully' do
        patch admins_department_module_path(@department, @module), params: { department_module: { name: 'updated' } }
        assert_redirected_to admins_department_path(@department)
        assert_equal I18n.t('flash.actions.update.m', resource_name: DepartmentModule.model_name.human),
                     flash[:success]
        @module.reload
        assert_equal 'updated', @module.name
      end

      should 'unsuccessfully' do
        patch admins_department_module_path(@department, @module), params: { department_module: { name: '' } }
        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]

        name = @module.name
        @module.reload
        assert_equal name, @module.name
      end
    end

    should 'destroy' do
      assert_difference('DepartmentModule.count', -1) do
        delete admins_department_module_path(@department, @module)
      end

      assert_redirected_to admins_department_path(@department)
    end
  end

  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [new_admins_department_module_path(1),
              edit_admins_department_module_path(1, 1)],
        post: [admins_department_modules_path(1)],
        patch: [admins_department_module_path(1, 1)],
        delete: [admins_department_module_path(1, 1)]
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
