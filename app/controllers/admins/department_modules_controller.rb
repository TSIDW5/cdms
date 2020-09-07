class Admins::DepartmentModulesController < Admins::BaseController
  before_action :set_department, except: [:users, :add_user, :destroy_user]
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

  def users
    @module = DepartmentModule.find(params[:module_id])
    @user_types = [
      [I18n.t('activerecord.attributes.department.collaborator'), ModuleUser.roles[:collaborator]],
      [I18n.t('activerecord.attributes.department.responsible'), ModuleUser.roles[:responsible]]
    ]
  end

  def add_user
    department_module = DepartmentModule.find_by(id: params[:module_id])
    user = User.find_by(id: params[:user_id])
    module_user = ModuleUser.new(user: user, department_module: department_module, role: params[:type_id].to_i)

    if module_user.save
      render json: { ok: true }
    else
      render json: { ok: false, errors: translate_errors(module_user.errors.messages) }
    end
  end

  def destroy_user
    user = ModuleUser.by_user_and_module(params[:user_id], params[:module_id]).first
    user.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: t('activerecord.models.user.one'))
    redirect_to admins_department_module_users_list_path(params[:module_id])
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

  def translate_errors(errors)
    errors.keys.map { |key| "#{t("activerecord.attributes.module_user.#{key}")} #{errors[key].join(', ')}" }
  end
end
