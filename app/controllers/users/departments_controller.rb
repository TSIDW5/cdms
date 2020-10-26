class Users::DepartmentsController < Users::BaseController
    before_action :set_department, except: [:index]
    include Breadcrumbs
  
    def index
        @departments = current_user.departments.all.search(params[:term]).page(params[:page])
    end
  
    def show; end
  
    def members
      breadcrumbs_members
  
      @department_user = DepartmentUser.new
      @department_users = @department.department_users.includes(:user)
    end
  
    def non_members
      non_members = @department.search_non_members(params[:term])
      render json: non_members.as_json(only: [:id, :name])
    end
  
    def add_member
      department_users = @department.department_users
      @department_user = department_users.new(department_users_params)
  
      if(@department.department_users.find_by(user_id: current_user.id).role.eql? "responsible")
        if @department_user.save
          flash[:success] = I18n.t('flash.actions.add.m', resource_name: User.model_name.human)
          redirect_to users_department_members_path(@department)
        else
          breadcrumbs_members
          @department_users = department_users.includes(:user)
          render :members
        end
      end
    end
  
    def remove_member
      if(@department.department_users.find_by(user_id: current_user.id).role.eql? "responsible")
        department_user = @department.department_users.find_by(user_id: params[:id])
        department_user.destroy
        flash[:success] = I18n.t('flash.actions.remove.m', resource_name: User.model_name.human)
        redirect_to users_department_members_path(@department)
      end
    end
  
    private
  
    def set_department
      id = params[:department_id] || params[:id]
      @department = Department.find(id)
    end
  
    def department_params
      params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
    end
  
    def department_users_params
      { user_id: params[:department_user][:user_id],
        role: params[:department_user][:role] }
    end
  
    def breadcrumbs_members
      add_breadcrumb I18n.t('views.breadcrumbs.show', model: Department.model_name.human, id: @department.id),
                     users_department_path(@department)
      add_breadcrumb I18n.t('views.department.members.name'), users_department_members_path(@department)
    end
  end
  