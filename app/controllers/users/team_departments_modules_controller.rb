class Users::TeamDepartmentsModulesController < Users::BaseController
  def index     
    @departmentsUser = DepartmentUser.includes(:department, :user).where(users: {id: current_user.id.to_s})
    @modulesUser =DepartmentModuleUser.includes(:department_module, :user).where(users: {id: current_user.id.to_s})

    @departments = []
    @departmentsUser.each do |dep_user|
      department = Hash.new
      modules = Array.new 
            
      @modulesUser.each do |mod_user|
        if dep_user.department.id == mod_user.department_module.department_id
          mod = Hash.new
          mod.store("role", mod_user.role)
          mod.store('module', mod_user.department_module)
          modules.push(mod)  
        end        
      end
      department.store("department", dep_user.department) 
      department.store("role", dep_user.role)
      department.store("modules", modules)
      @departments.push(department)
    end 
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
