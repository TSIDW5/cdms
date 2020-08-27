class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_module, only: [:show, :edit, :update, :destroy]


  def new
    @department = Department.find(params[:department_id])
    @module = DepartmentModule.new(department_id: @department.id)
  end
  
  def edit
    @department = Department.find(params[:department_id])
    @module = DepartmentModule.find(params[:id])
  end

  def show
  end

  def create
    @department = Department.find(params[:department_id])
    @module = @department.modules.new(module_params)

    if @module.save
      flash[:success] = t('flash.actions.create.m', { resource_name: t('activerecord.models.department_module.one') })
      redirect_to [:admins, @department]
    else
      render :new
    end
  end

  def update
   @department = Department.find(params[:department_id])
   if @module.update(module_params)
      flash[:success] = t('flash.actions.update.m', { resource_name: t('activerecord.models.department_module.one') })
      redirect_to [:admins, @department]
    else
      render :edit
    end
  end

  def destroy
    @department = Department.find(params[:department_id])
    @module.destroy
    flash[:success] = t('flash.actions.destroy.m', { resource_name: t('activerecord.models.department_module.one') })
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