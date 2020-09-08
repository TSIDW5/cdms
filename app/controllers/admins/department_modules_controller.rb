class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_department
  before_action :set_module, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs

  def new
    @module = @department.modules.new
    add_breadcrumb I18n.t('views.breadcrumbs.new_module'), new_admins_department_module_path
  end


  def edit
    add_breadcrumb I18n.t('views.breadcrumbs.module')+"##{@module.id}", admins_department_path(@department.id)
    add_breadcrumb I18n.t('views.breadcrumbs.edit'), edit_admins_department_module_path
  end

  def create
    @module = @department.modules.new(module_params)

    if @module.save
      flash[:success] = t('flash.actions.create.m', resource_name: t('activerecord.models.department_module.one'))
      redirect_to [:admins, @department]
    else
      flash[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @module.update(module_params)
      flash[:success] = t('flash.actions.update.m', resource_name: t('activerecord.models.department_module.one'))
      redirect_to [:admins, @department]
    else
      flash[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @module.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: t('activerecord.models.department_module.one'))
    redirect_to [:admins, @department]
  end

  private

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_module
    @module = @department.modules.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.home'), admins_root_path
    add_breadcrumb I18n.t('views.breadcrumbs.departments'), admins_departments_path
    add_breadcrumb I18n.t('views.breadcrumbs.department')+"##{@department.id}", admins_department_path(@department.id)
  end

  def module_params
    params.require(:department_module).permit(:name, :description)
  end
end
