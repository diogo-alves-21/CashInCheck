class Admin::ConsentsController < Admin::ApplicationController

  before_action :authenticate_admin!
  before_action :set_consent, only: [:show, :edit, :update, :destroy]

  # GET /admin/consents
  def index
    @pagy, @consents = pagy(Consent.order(created_at: :desc))
  end

  # GET /admin/consents/1
  def show; end

  # GET /admin/consents/new
  def new
    @consent = Consent.new
  end

  # GET /admin/consents/1/edit
  def edit; end

  # POST /admin/consents
  def create
    @consent = Consent.new(consent_params)
    respond_to do |format|
      if @consent.save
        format.html { redirect_to [:admin, @consent], notice: I18n.t('controllers.created', model: Consent.model_name.human(count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/consents/1
  def update
    respond_to do |format|
      if @consent.update(consent_params)
        format.html { redirect_to [:admin, @consent], notice: I18n.t('controllers.updated', model: Consent.model_name.human(count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/consents/1
  def destroy
    respond_to do |format|
      if @consent.destroy
        format.html { redirect_to admin_consents_url, notice: I18n.t('controllers.destroyed', model: Consent.model_name.human(count: 1)) }
      else
        format.html { redirect_to admin_consents_url, notice: I18n.t('controllers.destroy_error', model: Consent.model_name.human(count: 1)) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_consent
    @consent = Consent.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def consent_params
    params.expect(consent: [:kind, :active, :content])
  end

end
