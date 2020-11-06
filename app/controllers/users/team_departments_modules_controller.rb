class Users::TeamDepartmentsModulesController < Users::BaseController
  before_action :set_department, only: :show_department
  before_action :set_module, only: :show_module

  add_breadcrumb I18n.t('views.team.name.plural'), :users_team_departments_modules_path

  def index
    @departments = current_user.departments_and_modules
  end

  def show_department
    set_department
    add_breadcrumb I18n.t('views.department.links.show'), users_show_department_path(@department)
    @department_users = @department.department_users.includes(:user)
  end

  def show_module
    set_module
    add_breadcrumb I18n.t('views.department_module.links.show'), users_show_module_path(@department_module)
    @module_users = @department_module.department_module_users.includes(:user)
  end

  private

  def set_department
    id = params[:department_id] || params[:id]
    @department = current_user.departments.find_by(id: id)

    redirect_to users_team_departments_modules_path if @department.nil?
  end

  def set_module
    @department_module = current_user.department_modules.find_by(id: params[:id])

    redirect_to users_team_departments_modules_path if @department_module.nil?
  end
end
