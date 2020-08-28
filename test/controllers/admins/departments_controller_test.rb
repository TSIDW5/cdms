require 'test_helper'

class Admins::DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department = FactoryBot.create(:department)
  end

  context 'not logged in' do
    should 'redirect to sing_in' do
      get new_admins_department_url
      assert_response :redirect
      assert_redirected_to new_admin_session_url
    end
  end

  context 'logged in' do
    
    should 'get depatment index' do
      sign_in create(:admin)
      get admins_departments_url
      assert_response :success
    end

    should "get new depatment" do
      sign_in create(:admin)
      get new_admins_department_url
      assert_response :success
    end

    should "create department" do
      sign_in create(:admin)
      assert_difference('Department.count') do
        post admins_departments_url, params: { department: { description: @department.description, email: "email1@email.com", local: @department.local, name: @department.name, phone: @department.phone, initials: "dep1" } }
      end
      assert_redirected_to admins_departments_url
    end

    should "show department" do
      sign_in create(:admin)
      get admins_department_url(@department)
      assert_response :success
    end

    should "get edit department" do
      sign_in create(:admin)
      get edit_admins_department_url(@department)
      assert_response :success
    end

    should "update department" do
      sign_in create(:admin)
      patch admins_department_url(@department), params: { department: { description: @department.description, email: @department.email, local: @department.local, name: @department.name, phone: @department.phone, initials: @department.initials } }
      assert_redirected_to admins_departments_url
    end

    should "destroy department" do
      sign_in create(:admin)
      assert_difference('Department.count', -1) do
        delete admins_department_url(@department)
      end
      assert_redirected_to admins_departments_url
    end

  end
end