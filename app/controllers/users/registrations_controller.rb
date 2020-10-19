class Users::RegistrationsController < Devise::RegistrationsController
  layout 'layouts/users/application'
  before_action :set_breadcrumbs, only: [:edit, :update]

  protected

  def after_update_path_for(*)
    edit_user_registration_path
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :current_password, :password, :password_confirmation)
  end

  private

  def set_breadcrumbs
    add_breadcrumb I18n.t('views.breadcrumbs.home'), :users_root_path
    add_breadcrumb I18n.t('devise.registrations.edit.title'), :edit_user_registration_path
  end
end
