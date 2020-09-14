class Admins::AdminsController < Admins::BaseController
  before_action :set_admin, only: [:show, :edit, :update, :remove_as_admin, :destroy]

  def index
    @admins = User.includes(:role).where.not(:role_id => nil)
  end

  def show
    set_role
  end

  def new
    @admin = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def remove_as_admin
    begin
      @admin.can_destroy?
      if @admin.update({role_id: nil })
        flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
        redirect_to admins_admins_path
      else
        flash[:error] = I18n.t('flash.actions.destroy.user_admin')
        redirect_to admins_admins_path
      end
    rescue
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
      redirect_to admins_admins_path
    end
  end

  def get_users_non_admin
    keyword = params[:keyword]

    users = User.where(:role_id => nil).where("username LIKE ?", "%#{keyword}%")
    render json: { ok: true, users: users }
  end

  def set_user_as_admin
    @admin = User.find(params[:user][:id])
    if @admin.update({role_id: params[:user][:role_id] })
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_admins_path
    else
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
      redirect_to admins_admins_path
    end
  end

  def create    
    @admin = User.new(user_params)
    if @admin.save
      flash[:success] = t('flash.actions.create.m', resource_name: User.model_name.human)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      @roles = Role.all
      render :new
    end
  end

  def update
    if @admin.update(user_params)
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      flash[:success] = t('flash.actions.destroy.m', resource_name: User.model_name.human)
    else
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
    end
    redirect_to admins_admins_path
  end

  private

  def set_admin
    @admin = User.find(params[:id] || params[:admin_id])
  end

  def set_role
    @role = @admin.role_id ? Role.find(@admin.role_id) : Role.new
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :active, :avatar, :role_id)
  end
end
