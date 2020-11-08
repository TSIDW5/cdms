class Admins::AdministratorsController < Admins::BaseController
  add_breadcrumb Administrator.model_name.human(count: 2), :admins_administrators_path

  def index
    @administrators = User.admins
    @administrator = Administrator.new
  end

  def create
    @administrator = Administrator.new(params[:administrator])

    if @administrator.save
      flash[:success] = I18n.t('flash.actions.add.m', resource_name: resource_name)
      redirect_to admins_administrators_path
    else
      error_message
      @administrators = User.admins
      render :index
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.last_manager?
      flash[:warning] = I18n.t('flash.actions.least', resource_name: resource_name)
    else
      user.update(role_id: nil)
      flash[:success] = I18n.t('flash.actions.remove.m', resource_name: resource_name)
    end

    redirect_to admins_administrators_path
  end

  def search_non_admins
    users = User.search_non_admins(params[:term])
    render json: users.as_json(only: [:id, :name])
  end

  private

  def resource_name
    Administrator.model_name.human
  end
end
