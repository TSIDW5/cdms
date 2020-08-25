class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_module, only: [:show, :edit, :update, :destroy]


  def show
  end

  def create
    @department = Department.find(params[:department_id])
    @module = @department.modules.new(module_params)

    if @module.save
      redirect_to [:admins, @department], notice: 'Departments module was successfully created.'
    else
      render 'admins/departments/show'
    end
  end

  def update
    if @department_module.update(departments_module_params)
      redirect_to @departments_module, notice: 'Departments module was successfully updated.'
    else
      render 'admins/departments/show'
    end
  end

  def destroy
    @department = Department.find(params[:department_id])
    @module.destroy
    redirect_to [:admins, @department], notice: 'Departments module was successfully destroyed.'
  end

  private
    def set_module
      @module = DepartmentModule.find(params[:id])
    end

    def module_params
      params.require(:department_module).permit(:name, :description)
    end
end