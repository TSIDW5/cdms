class Users::DocumentsController < Users::BaseController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_departments, only: [:edit, :new, :update, :create]
  include Breadcrumbs

  def index
    @documents = Document.search(params[:term]).page(params[:page]).includes(:department)
  end

  def show; end

  def new
    @document = Document.new
  end

  def edit; end

  def create
    @document = Document.new(document_params)
    if @document.save
      flash[:success] = t('flash.actions.create.m', resource_name: Document.model_name.human)
      redirect_to users_documents_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @document.update(document_params)
      flash[:success] = t('flash.actions.update.m', resource_name: Document.model_name.human)
      redirect_to users_documents_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @document.destroy
      flash[:success] = t('flash.actions.destroy.m', resource_name: Document.model_name.human)
    else
      flash[:warning] = @document.errors.messages[:base].join
    end
    redirect_to users_documents_path
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def set_departments
    @departments = current_user.departments
  end

  def document_params
    params.require(:document).permit(:title, :front_text, :back_text, :category, :department_id)
  end
end
