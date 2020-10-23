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
end
