class Admins::AudienceMembersController < Admins::BaseController
  def index
    @audience_members = AudienceMember.all
  end

  def new
    @audience_member = AudienceMember.new
  end

  def create
    audience_member = AudienceMember.new(audience_member_params)

    if audience_member.valid?
      save_audience_member(audience_member, false)
    else
      @audience_member = audience_member
      render :new
    end
  end

  def edit
    set_audience_member
  end

  def update
    audience_member = AudienceMember.find(params[:id])
    audience_member.name = audience_member_params[:name]
    audience_member.email = audience_member_params[:email]
    audience_member.cpf = audience_member_params[:cpf]

    if !audience_member
      audience_member_not_found
    else
      save_audience_member(audience_member, true)
    end
  end

  def destroy
    audience_member = AudienceMember.find(params[:id])

    if audience_member
      audience_member.destroy
      flash[:success] = t('flash.actions.destroy.m', { resource_name: t('activerecord.models.audience_member.one') })
      redirect_to admins_audience_members_path
    else
      audience_member_not_found
    end
  end

  def show
    set_audience_member
  end

  private

  def set_audience_member
    @audience_member = AudienceMember.find(params[:id])
  end

  def audience_member_params
    params.require(:audience_member).permit(:id, :name, :email, :cpf)
  end

  def audience_member_not_found
    flash[:error] = t('flash.not_found')
    redirect_to admins_audience_members_path
  end

  def save_audience_member(audience_member, is_editing)
    i18n_key = is_editing ? 'update' : 'create'
    if audience_member.valid?
      audience_member.save
      flash[:success] =
        t("flash.actions.#{i18n_key}.m", { resource_name: t('activerecord.models.audience_member.one') })
      redirect_to admins_audience_members_path
    else
      @audience_member = audience_member
      render is_editing ? :edit : :new
    end
  end
end
