class Admins::DepartmentsController < Admins::BaseController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
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

  def edit
    @department = Department.find(params[:id])
  end

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

  def destroy_user
    user = DepartmentUser.by_user_and_department(params[:user_id], params[:department_id]).first
    user.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: t('activerecord.models.user.one'))
    redirect_to admins_department_users_list_path(params[:department_id])
  end

  def users
    @department = Department.find(params[:department_id])
    @user_types = [
      [I18n.t('activerecord.attributes.department.collaborator'), DepartmentUser.roles[:collaborator]],
      [I18n.t('activerecord.attributes.department.responsible'), DepartmentUser.roles[:responsible]]
    ]
  end

  def add_user
    department = Department.find_by(id: params[:department_id])
    user = User.find_by(id: params[:user_id])
    department_user = DepartmentUser.new(user: user, department: department, role: params[:type_id].to_i)

    if department_user.save
      render json: { ok: true }
    else
      render json: { ok: false, errors: translate_errors(department_user.errors.messages) }
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
  end

  def translate_errors(errors)
    errors.keys.map { |key| "#{t("activerecord.attributes.department_user.#{key}")} #{errors[key].join(', ')}" }
  end
end
