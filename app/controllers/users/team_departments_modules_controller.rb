class Users::TeamDepartmentsModulesController < Users::BaseController
  def index     
      @departments = current_user.departments_and_modules
  end

  def show_department    
    validation_department_current_user
    @department_users = @department.department_users.includes(:user)
  end

  def show_module    
    validation_module_current_user
    @module_users =  @department_module.department_module_users.includes(:user)
  end

  private
  def validation_department_current_user
    id = params[:department_id] || params[:id]
    @department = Department.find(id)

    if (@department.department_users.where(user_id: current_user.id.to_s).empty?)
      redirect_to users_team_departments_modules_path
    end
  end

  def validation_module_current_user
    id = params[:id]
    @department_module = DepartmentModule.find(id)

    if (@department_module.department_module_users.where(user_id: current_user.id.to_s).empty?)
      redirect_to users_team_departments_modules_path
    end
  end
  
end
