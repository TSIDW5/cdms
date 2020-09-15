require 'test_helper'

class Admins::DepartmentsControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      @department = create(:department)
      sign_in create(:admin)
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

  context 'add breadcrumbs' do
    should 'have index departments path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.departments'), admins_departments_path)
      assert_equal "/admins/departments", element.path
      assert_equal "Departamentos", element.name
    end 

    should 'have new department path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.new'), new_admins_department_path)
      assert_equal "/admins/departments/new", element.path
      assert_equal "Novo", element.name
    end 

    should 'have show department path'do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.department')+ " #1", admins_department_path(1))
      assert_equal "/admins/departments/1", element.path
      assert_equal "Departamento #1", element.name
    end

    should 'have edit department path' do
      element = BreadcrumbsOnRails::Breadcrumbs::Element.new(I18n.t('views.breadcrumbs.edit'), edit_admins_department_path(1))
      assert_equal "/admins/departments/1/edit", element.path
      assert_equal "Editar", element.name
    end
  end
end
