require 'test_helper'

class DepartmentModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @departments_module = departments_modules(:one)
  end

  test "should get index" do
    get departments_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_departments_module_url
    assert_response :success
  end

  test "should create departments_module" do
    assert_difference('DepartmentsModule.count') do
      post departments_modules_url, params: { departments_module: { departments_id: @departments_module.departments_id, description: @departments_module.description, name: @departments_module.name } }
    end

    assert_redirected_to departments_module_url(DepartmentsModule.last)
  end

  test "should show departments_module" do
    get departments_module_url(@departments_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_departments_module_url(@departments_module)
    assert_response :success
  end

  test "should update departments_module" do
    patch departments_module_url(@departments_module), params: { departments_module: { departments_id: @departments_module.departments_id, description: @departments_module.description, name: @departments_module.name } }
    assert_redirected_to departments_module_url(@departments_module)
  end

  test "should destroy departments_module" do
    assert_difference('DepartmentsModule.count', -1) do
      delete departments_module_url(@departments_module)
    end

    assert_redirected_to departments_modules_url
  end
end
