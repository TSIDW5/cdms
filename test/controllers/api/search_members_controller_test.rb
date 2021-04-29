require 'test_helper'

class Api::SearchMembersControllerTest < ActionDispatch::IntegrationTest

    context 'autenticated' do
        setup do
          @module = create(:department_module)
          @department = @module.department
          @user = create(:user)
          sign_in create(:user, :manager)
        end
        
        
        should 'search_department_non_members' do
            user = create(:user)
            get api_search_non_members_path(@department, nil, user.name)

            jresponse = JSON.parse(response.body)
            assert_equal [user.as_json(only: [:id, :name])], jresponse
        end

        should 'search_department_module_non_members' do
            user = create(:user)
            get api_search_non_members_path(@department, @module, user.name)
           
            jresponse = JSON.parse(response.body)
            assert_equal [user.as_json(only: [:id, :name])], jresponse
        end

    end

end
