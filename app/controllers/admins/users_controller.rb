class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('flash.actions.create.m', resource_name: User.model_name.human)
      redirect_to admins_users_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_users_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: User.model_name.human)
    redirect_to admins_users_path
  end

  def search
    keyword = params[:keyword]

    if !params[:department_id].nil?
      department_id = params[:department_id]
      department = Department.find(department_id)
      users = User.filter_of_department_by_name(keyword, department).sorted

      render json: { ok: true, users: users }
    elsif !params[:module_id].nil?
      module_id = params[:module_id]
      department_module = DepartmentModule.find(module_id)
      users = User.filter_of_module_by_name(keyword, department_module).sorted

      render json: { ok: true, users: users }
    else
      render json: { ok: false }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :active, :avatar)
  end
end
