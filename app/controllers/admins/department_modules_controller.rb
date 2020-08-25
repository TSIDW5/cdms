class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_module, only: [:show, :edit, :update, :destroy]


  def show
  end

  def create
    @department = Department.find(params[:department_id])
    @module = @department.modules.new(module_params)

    if @module.save
      flash[:success] = I18n.t('flash.actions.create.m', { resource_name: I18n.t('activerecord.models.department_module.one') })
      redirect_to [:admins, @department]
    else
      render 'admins/departments/show'
    end
  end

  def update
    if @department_module.update(departments_module_params)
      flash[:success] = I18n.t('flash.actions.update.m', { resource_name: I18n.t('activerecord.models.department_module.one') })
      redirect_to @departments_module
    else
      render 'admins/departments/show'
    end
  end

  def destroy
    @department = Department.find(params[:department_id])
    @module.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', { resource_name: I18n.t('activerecord.models.department_module.one') })
    redirect_to [:admins, @department]
  end

  private
    def set_module
      @module = DepartmentModule.find(params[:id])
    end

    def module_params
      params.require(:department_module).permit(:name, :description)
    end
end