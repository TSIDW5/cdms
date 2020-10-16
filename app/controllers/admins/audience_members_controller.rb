class Admins::AudienceMembersController < Admins::BaseController
  before_action :set_audience_member, only: [:edit, :update, :show, :destroy]
  include Breadcrumbs

  def index
    @audience_members = AudienceMember.search(params[:term]).page(params[:page])
  end

  def new
    @audience_member = AudienceMember.new
  end

  def show; end

  def create
    @audience_member = AudienceMember.new(audience_member_params)
    save_audience_member
  end

  def edit; end

  def update
    @audience_member.assign_attributes(audience_member_params)
    save_audience_member
  end

  def destroy
    @audience_member.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: t('activerecord.models.audience_member.one'))
    redirect_to admins_audience_members_path
  end

  private

  def set_audience_member
    @audience_member = AudienceMember.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('flash.not_found')
    redirect_to admins_audience_members_path
  end

  def audience_member_params
    params.require(:audience_member).permit(:id, :name, :email, :cpf)
  end

  def save_audience_member
    if @audience_member.save
      flash[:success] = t("flash.actions.#{action_name}.m", resource_name: t('activerecord.models.audience_member.one'))
      redirect_to admins_audience_members_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render @audience_member.new_record? ? :new : :edit
    end
  end
end
