require 'test_helper'

class Users::DepartmentsControllerTest < ActionDispatch::IntegrationTest

    context 'authenticated with responsible user' do
        setup do
            @department_user = create(:department_user, :responsible)
            sign_in @department_user.user
        end
    
        should 'get index' do
            get users_departments_path
            assert_response :success
            assert_active_link(href: users_departments_path)
        end

        should 'get show' do
            get users_departments_path(@department_user.department)
            assert_response :success
            assert_active_link(href: users_departments_path)
        end

        should 'get members' do
            get users_department_members_path(@department_user.department)
            assert_response :success
        end
        
        should "add member" do
            new_user = create(:user)
            post users_department_add_member_path(@department_user.department), params: { department_user: 
                {user_id: new_user.id, department_id: @department_user.department.id, role: :collaborator} }
            assert_equal 2, @department_user.department.users.count
            assert_redirected_to  users_department_members_path(@department_user.department)
        end

        should "not add member" do
            new_user = create(:user)
            post users_department_add_member_path(@department_user.department), params: { department_user: 
                {user_id: new_user.id, department_id: @department_user.department.id, role: :responsible} }
            @department_user.department.reload
            assert_equal 1, @department_user.department.users.count
        end

        should "delete member" do
            new_user = create(:user)
            post users_department_add_member_path(@department_user.department), params: { department_user: 
                {user_id: new_user.id, department_id: @department_user.department.id, role: :collaborator} }
            delete users_department_remove_member_path(@department_user.department, new_user)
            assert_equal 1, @department_user.department.users.count
        end
    end

    context 'authenticated with collaborator user' do
        setup do
            @department_user = create(:department_user, :collaborator)
            sign_in @department_user.user
        end

        should 'get index' do
            get users_departments_path
            assert_response :success
            assert_active_link(href: users_departments_path)
        end

        should 'get show' do
            get users_departments_path(@department_user.department)
            assert_response :success
            assert_active_link(href: users_departments_path)
        end

        should "not allow add member" do
            new_user = create(:user)
            post users_department_add_member_path(@department_user.department), params: { department_user: 
                {user_id: new_user.id, department_id: @department_user.department.id, role: :collaborator} }
            @department_user.department.reload
            assert_equal 1, @department_user.department.users.count
        end

        should "not allow delete member" do
            delete users_department_remove_member_path(@department_user.department, @department_user.user)
            assert_equal 1, @department_user.department.users.count
        end
    end
end
