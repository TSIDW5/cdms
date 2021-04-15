require 'application_system_test_case'

class MembersTest < ApplicationSystemTestCase

  context 'department module' do
     setup do
       user = create(:user, :manager)
       login_as(user, scope: :user)
     end

     context 'add member' do
        setup do
          @user = create(:user)
          @module = create(:department_module)
          @department = @module.department
          visit admins_department_module_members_path(@department, @module)
        end

        should 'successfully' do
          fill_in 'department_module_user_user', with: @user.name
          find("#department_module_user_user-dropdown .dropdown-item[data-value='#{@user.id}']").click

          find("#department_module_user_role-selectized").click
          find(".selectize-dropdown .option[data-value="'collaborator'"]").click

          submit_form("button[type='submit']")


          base_selector = ".table tbody tr:nth-child(1)"
          assert_selector(base_selector, text: @user.name)
          assert_selector(base_selector, text: @user.email)
          assert_selector(base_selector, text: @user.role)
        end
        
        should 'unsuccessfully' do
          fill_in 'department_module_user_user', with: @user.name
          find("#department_module_user_user-dropdown .dropdown-item[data-value='#{@user.id}']").click
         
          submit_form("button[type='submit']")  

          
        end
     end
  end


end
