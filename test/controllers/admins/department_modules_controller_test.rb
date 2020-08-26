require 'test_helper'

class Admins::DepartmentModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department_module = FactoryBot.create(:department_module)
  end
  
  context 'logged in' do
    should "create department_module" do
      sign_in create(:admin)
      assert_difference('DepartmentModule.count') do
        post admins_department_department_modules_path(@department_module.department), params: { department_module: { departments_id: @department_module.department_id, description: "teste", name: "teste2" } }
      end
      assert_redirected_to admins_department_path(@department_module.department)
    end

    should "update departments_module" do
      sign_in create(:admin)
      patch admins_department_department_module_url(@department_module.department, @department_module), params: { department_module: { department_id: @department_module.department_id, description: @department_module.description, name: @department_module.name } }
      assert_redirected_to admins_department_path(@department_module.department)
    end

    should "destroy departments_module" do
      sign_in create(:admin)
      assert_difference('DepartmentModule.count', -1) do
        delete admins_department_department_module_url(@department_module.department, @department_module)
      end
      assert_redirected_to admins_department_path(@department_module.department)
    end

  end
end



