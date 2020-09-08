class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_breadcrumbs

  def index
    @users = User.all
  end

  def show
    add_breadcrumb I18n.t('views.breadcrumbs.user')+"##{@user.id}", admins_user_path(@user.id)
  end

  def new
    @user = User.new
    add_breadcrumb I18n.t('views.breadcrumbs.new'), new_admins_user_path
  end

  def edit
    add_breadcrumb I18n.t('views.breadcrumbs.user')+"##{@user.id}", admins_user_path(@user.id)
    add_breadcrumb I18n.t('views.breadcrumbs.edit'), edit_admins_user_path
  end

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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.home'), admins_root_path
    add_breadcrumb I18n.t('views.breadcrumbs.users'), admins_users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :active, :avatar)
  end
end
