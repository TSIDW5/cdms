class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_department
  before_action :set_module, only: [:edit, :update, :destroy]

  def new
    @module = @department.modules.new
  end

  def edit; end

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

  def module_params
    params.require(:department_module).permit(:name, :description)
  end
end
