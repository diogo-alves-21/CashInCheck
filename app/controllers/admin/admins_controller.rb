class Admin::AdminsController < Admin::ApplicationController

  before_action :authenticate_admin!
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admin/admins
  def index
    @pagy, @admins = pagy(Admin.all)
    authorize @admins
  end

  # GET /admin/admins/1
  def show; end

  # GET /admin/admins/new
  def new
    authorize Admin.new
    @admin = Admin.new
  end

  # GET /admin/admins/1/edit
  def edit; end

  # POST /admin/admins
  def create
    @admin = Admin.invite!(email: admin_params[:email])
    # @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.valid?
        format.html { redirect_to [:admin, @admin], notice: I18n.t('controllers.created', model: Admin.model_name.human(count: 1)) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/admins/1
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to [:admin, @admin], notice: I18n.t('controllers.updated', model: Admin.model_name.human(count: 1)) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/admins/1
  def destroy
    respond_to do |format|
      if @admin.destroy
        format.html { redirect_to admin_admins_url, notice: I18n.t('controllers.destroyed', model: Admin.model_name.human(count: 1)) }
      else
        format.html { redirect_to admin_admins_url, alert: I18n.t('controllers.destroy_error', model: Admin.model_name.human(count: 1)) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
    authorize @admin
  end

  # Only allow a trusted parameter "white list" through.
  def admin_params
    params.expect(admin: [:email])
  end

end
