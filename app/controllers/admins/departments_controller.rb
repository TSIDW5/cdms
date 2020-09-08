class Admins::DepartmentsController < Admins::BaseController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :set_breadcrumbs

  def index
    @departments = Department.all
  end

  def show
    @module = DepartmentModule.new(department_id: @department.id)
    add_breadcrumb "Departamento##{@department.id}", admins_department_path(@department.id)
  end

  def new
    @department = Department.new
    add_breadcrumb "Novo", new_admins_department_path
  end

  def edit
    @department = Department.find(params[:id])
    add_breadcrumb "Departamento##{@department.id}", admins_department_path(@department.id)
    add_breadcrumb "Editar", edit_admins_department_path
  end

  def create
    @department = Department.new(department_params)

    if @department.save
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: I18n.t('activerecord.models.department.one'))
      redirect_to admins_departments_path
    else
      flash[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @department.update(department_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: I18n.t('activerecord.models.department.one'))
      redirect_to admins_departments_path
    else
      flash[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @department.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: I18n.t('activerecord.models.department.one'))
    redirect_to admins_departments_path
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb "Página Inicial", admins_root_path
    add_breadcrumb "Departamentos", admins_departments_path
  end

  def department_params
    params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
  end
end
