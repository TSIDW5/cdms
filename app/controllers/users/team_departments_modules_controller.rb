class Users::TeamDepartmentsModulesController < Users::BaseController
  before_action :breadcrumbs_team

  def index
    @departments = current_user.departments_and_modules
  end

  def show_department
    validation_department_current_user
    @department = Department.find(@id)
    add_breadcrumb I18n.t('views.department.links.show'), users_show_department_path(@department)
    @department_users = @department.department_users.includes(:user)
  end

  def show_module
    validation_module_current_user
    @department_module = DepartmentModule.find(@id)
    add_breadcrumb I18n.t('views.department_module.links.show'), users_show_module_path(@department_module)
    @module_users = @department_module.department_module_users.includes(:user)
  end

  private

  def validation_department_current_user
    @id = params[:department_id] || params[:id]
    return unless current_user.departments.where(id: @id).empty?

    redirect_to users_team_departments_modules_path
  end

  def validation_module_current_user
    @id = params[:id]

    return unless current_user.department_modules.where(id: @id).empty?

    redirect_to users_team_departments_modules_path
  end

  def breadcrumbs_team
    add_breadcrumb I18n.t('views.team.name.plural'), :users_team_departments_modules_path
  end
end
