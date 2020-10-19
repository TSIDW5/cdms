class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  include Breadcrumbs

  def index
    @users = User.search(params[:term]).page(params[:page])
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
    remove_empty_password

    if @user.update(user_params)
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_users_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('flash.actions.destroy.m', resource_name: User.model_name.human)
    else
      flash[:warning] = @user.errors.messages[:base].join
    end
    redirect_to admins_users_path
  end

  private

  def remove_empty_password
    return if params[:user][:password].present?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number,
                                 :cpf, :active, :avatar, :password, :password_confirmation)
  end
end
