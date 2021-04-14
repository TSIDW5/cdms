class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_department
  before_action :set_module, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs
  before_action :set_update_breadcrumbs, only: [:edit, :update]
  before_action :set_create_breadcrumbs, only: [:new, :create]

  def new
    @module = @department.modules.new
  end

  def edit; end

  def create
    @module = @department.modules.new(module_params)

    if @module.save
      success_create_message
      redirect_to [:admins, @department]
    else
      error_message
      render :new
    end
  end

  def update
    if @module.update(module_params)
      success_update_message
      redirect_to [:admins, @department]
    else
      error_message
      render :edit
    end
  end

  def destroy
    @module.destroy
    success_destroy_message
    redirect_to [:admins, @department]
  end

  def members
    breadcrumbs_members
    @department_module_user = DepartmentModuleUser.new
    set_module
    set_modules
  end

  def module_non_members
    set_module
    non_members = @module.search_non_members(params[:term])
    render json: non_members.as_json(only: [:id, :name])
  end

  def add_module_member
    breadcrumbs_members
    @module_user = @module.department_module_users.new(department_module_users_params)
    if @module_user.save
      flash[:success] = I18n.t('flash.actions.add.m', resource_name: User.model_name.human)
      redirect_to admins_department_module_members_path(@department, @module)
    else
      set_modules
      @department_module_user = DepartmentModuleUser.new
      render :members
    end
  end

  def remove_module_member
    breadcrumbs_members
    set_module
    module_user = @module.department_module_users.find_by(user_id: params[:user_id])
    module_user.destroy
    flash[:success] = I18n.t('flash.actions.remove.m', resource_name: User.model_name.human)
    redirect_to admins_department_module_members_path(@department, @module)
  end

  private

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_modules
    set_module
    @department_module_users = @module.department_module_users.includes(:user)
  end

  def set_module
    @module = @department.modules.find(params[:id])
  end

  def module_params
    params.require(:department_module).permit(:name, :description)
  end

  def department_module_users_params
    { user_id: params[:department_module_user][:user_id],
      role: params[:department_module_user][:role] }
  end

  def set_breadcrumbs
    add_breadcrumb @department.model_name.human(count: 2), admins_departments_path
    add_breadcrumb I18n.t('views.breadcrumbs.show', model: @department.model_name.human, id: @department.id),
                   admins_department_path(@department)
  end

  def set_update_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.show', model: @module.model_name.human, id: @module.id),
                   admins_department_path(@department.id)
    add_breadcrumb I18n.t('views.breadcrumbs.edit'), edit_admins_department_module_path
  end

  def set_create_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.new.m'), new_admins_department_module_path
  end

  def breadcrumbs_members
    set_module
    add_breadcrumb I18n.t('views.breadcrumbs.show', model: DepartmentModule.model_name.human, id: @module.id),
                   admins_department_path(@department)
    add_breadcrumb I18n.t('views.department_module.members.name'), admins_department_module_members_path(@department)
  end
end
