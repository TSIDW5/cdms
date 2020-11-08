class Admins::DepartmentsController < Admins::BaseController
  before_action :set_department, except: [:index, :new, :create]
  include Breadcrumbs

  def index
    @departments = Department.search(params[:term]).page(params[:page])
  end

  def show
    @module = DepartmentModule.new(department_id: @department.id)
  end

  def new
    @department = Department.new
  end

  def edit; end

  def create
    @department = Department.new(department_params)

    if @department.save
      success_create_message
      redirect_to admins_departments_path
    else
      error_message
      render :new
    end
  end

  def update
    if @department.update(department_params)
      success_update_message
      redirect_to admins_departments_path
    else
      error_message
      render :edit
    end
  end

  def destroy
    @department.destroy
    success_destroy_message
    redirect_to admins_departments_path
  end

  def members
    breadcrumbs_members

    @department_user = DepartmentUser.new
    set_departments
  end

  def non_members
    non_members = @department.search_non_members(params[:term])
    render json: non_members.as_json(only: [:id, :name])
  end

  def add_member
    @department_user = @department.department_users.new(department_users_params)

    if @department_user.save
      flash[:success] = I18n.t('flash.actions.add.m', resource_name: User.model_name.human)
      redirect_to admins_department_members_path(@department)
    else
      breadcrumbs_members
      set_departments
      render :members
    end
  end

  def remove_member
    department_user = @department.department_users.find_by(user_id: params[:id])
    department_user.destroy
    flash[:success] = I18n.t('flash.actions.remove.m', resource_name: User.model_name.human)
    redirect_to admins_department_members_path(@department)
  end

  private

  def set_department
    id = params[:department_id] || params[:id]
    @department = Department.find(id)
  end

  def set_departments
    @department_users = @department.department_users.includes(:user)
  end

  def department_params
    params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
  end

  def department_users_params
    { user_id: params[:department_user][:user_id],
      role: params[:department_user][:role] }
  end

  def breadcrumbs_members
    add_breadcrumb I18n.t('views.breadcrumbs.show', model: Department.model_name.human, id: @department.id),
                   admins_department_path(@department)
    add_breadcrumb I18n.t('views.department.members.name'), admins_department_members_path(@department)
  end
end
