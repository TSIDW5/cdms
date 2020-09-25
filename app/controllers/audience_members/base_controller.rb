class AudienceMembers::BaseController < ActionController::Base
  layout 'layouts/audience_members/application'

  add_breadcrumb I18n.t('views.breadcrumbs.home'), :audience_members_root_path
end
