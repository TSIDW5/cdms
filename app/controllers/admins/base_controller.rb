class Admins::BaseController < ActionController::Base
  layout 'layouts/admins/application'

  add_breadcrumb I18n.t('views.breadcrumbs.home'), :admins_root_path

  def add_message(type, text)
    @messages ||= []
    @messages.push({type: type, text: text})
  end

end
