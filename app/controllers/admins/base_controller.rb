class Admins::BaseController < ActionController::Base
  before_action :base_breadcrumb
  layout 'layouts/admins/application'

  def base_breadcrumb
    add_breadcrumb I18n.t('views.breadcrumbs.home'), admins_root_path
  end

end
