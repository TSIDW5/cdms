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

  private

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_module
    @module = @department.modules.find(params[:id])
  end

  def module_params
    params.require(:department_module).permit(:name, :description)
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
end
