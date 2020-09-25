class AudienceMembers::RegistrationsController < Devise::RegistrationsController
  layout 'layouts/audience_members/application'

  protected

  def after_update_path_for(*)
    edit_audience_member_registration_path
  end

  def account_update_params
    params.require(:audience_member).permit(:name, :email, :current_password, :password, :password_confirmation)
  end
end
