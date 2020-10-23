class Users::TeamDepartmentsModulesController < Users::BaseController
  def index     
     @departmentsUser = DepartmentUser.includes(:department, :user).where(users: {id: current_user.id.to_s})
     @modulesUser =DepartmentModuleUser.includes(:department_module, :user).where(users: {id: current_user.id.to_s})

     puts(@departmentsUser)
     puts(@modulesUser)
  end
end