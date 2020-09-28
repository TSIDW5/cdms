class Admins::DepartmentsController < Admins::BaseController
  before_action :set_department, except: [:index, :new, :create]
  include Breadcrumbs

  def index
    @departments = Department.all
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
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: I18n.t('activerecord.models.department.one'))
      redirect_to admins_departments_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @department.update(department_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: I18n.t('activerecord.models.department.one'))
      redirect_to admins_departments_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @department.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: I18n.t('activerecord.models.department.one'))
    redirect_to admins_departments_path
  end

  def members
    breadcrumbs_members

    @department_user = DepartmentUser.new
    @department_users = @department.department_users.includes(:user)
  end

  def non_members
    non_members = @department.search_non_members(params[:term])
    render json: non_members.as_json(only: [:id, :name])
  end

  def add_member
    department_users = @department.department_users
    @department_user = department_users.new(department_users_params)

    if @department_user.save
      flash[:success] = I18n.t('flash.actions.add.m', resource_name: User.model_name.human)
      redirect_to admins_department_members_path(@department)
    else
      breadcrumbs_members
      @department_users = department_users.includes(:user)
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
