class Admins::BaseController < ActionController::Base
  include FlashMessage

  layout 'layouts/admins/application'

  before_action :verify_user_access

  add_breadcrumb I18n.t('views.breadcrumbs.home'), :admins_root_path

  def verify_user_access
    access_unauthorized unless current_user.is?(:admin)
  end

  def access_unauthorized
    flash[:error] = I18n.t('flash.not_authorized')
    redirect_to users_root_path
  end
end
