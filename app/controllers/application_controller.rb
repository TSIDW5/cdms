class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protected

  def after_sign_in_path_for(*)     
    current_admin ? admins_root_path : audience_member_registration_path   
  end

  def after_sign_out_path_for(*)
    new_admin_session_path
  end

  def layout_by_resource
    return 'layouts/devise/session' if devise_controller?

    'layouts/application'
  end
end
