class Admins::AudienceMembersController < Admins::BaseController
  before_action :set_audience_member, only: [:edit, :update, :show, :destroy]
  include Breadcrumbs

  def index
    @audience_members = AudienceMember.all
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

  def new_import
    @errors = []
  end

  def import
    @import_file = ImportFile.new(params[:import_file])

    flash[:error] = @import_file.errors.full_messages.join(' - ')

    @errors = %w[erro1 erro2]

    render :new_import

    # file = params[:file]
    # if file.nil? || File.extname(file) != '.csv'
    #   add_message(:error, I18n.t('views.audience_member.import.invalid_file'))
    # else
    #   result = AudienceMember.my_import(file)
    #   if result[0].num_inserts.positive?
    #     flash[:success] = t('flash.actions.import.m', resource_name: t('activerecord.models.audience_member.other'))
    #   end
    #   unless result[1].empty?
    #     result[1].each do |audience_member|
    #       add_message(:error, "#{audience_member.name} = #{audience_member.errors.full_messages.join(' - ')}")
    #     end
    #   end      
    # end
  end

  private

  def set_audience_member
    @audience_member = AudienceMember.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('flash.not_found')
    redirect_to admins_audience_members_path
  end

  def audience_member_params
    params.require(:audience_member).permit(:id, :name, :email, :cpf, :password, :password_confirmation)
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
