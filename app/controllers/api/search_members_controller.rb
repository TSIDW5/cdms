class Api::SearchMembersController < ActionController::API

    def search_non_members
        department = Department.find(params[:department_id])
        if(params[:module_id] == nil)
            non_members = department.search_non_members(params[:term])
            render json: non_members.as_json(only: [:id, :name])
        else
            department_module = department.modules.find(params[:module_id])
            non_members = department_module.search_non_members(params[:term])
            render json: non_members.as_json(only: [:id, :name])
        end
    end
end
