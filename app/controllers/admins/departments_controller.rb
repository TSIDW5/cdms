class Admins::DepartmentsController < Admins::BaseController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def index
    @departments = Department.all
  end

  def show
    @module = DepartmentModule.new(department_id: @department.id)
  end

  def new
    @department = Department.new
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to admins_departments_path, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def update
    if @department.update(department_params)
      redirect_to admins_departments_path, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to admins_departments_path, notice: 'Department was successfully destroyed.'
  end

  private
    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
    end
end
