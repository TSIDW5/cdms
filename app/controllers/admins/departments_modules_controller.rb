class Admins::DepartmentsModulesController < Admins::BaseController
  before_action :set_departments_module, only: [:show, :edit, :update, :destroy]

  # GET /departments_modules
  def index
    @departments_modules = DepartmentsModule.all
  end

  # GET /departments_modules/1
  def show
  end

  # GET /departments_modules/new
  def new
    @departments_module = DepartmentsModule.new
  end

  # GET /departments_modules/1/edit
  def edit
  end

  # POST /departments_modules
  def create
    @department = Department.find(params[:departments_id])
    @departments_module = @department.departmentsModule.new(departments_module_params)

    if @departments_module.save
      redirect_to @departments_module, notice: 'Departments module was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /departments_modules/1
  def update
    if @departments_module.update(departments_module_params)
      redirect_to @departments_module, notice: 'Departments module was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /departments_modules/1
  def destroy
    @departments_module.destroy
    redirect_to departments_modules_url, notice: 'Departments module was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departments_module
      @departments_module = DepartmentsModule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def departments_module_params
      params.require(:departments_module).permit(:departments_id, :name, :description)
    end
end
