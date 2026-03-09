class ConsentsController < ApplicationController

  include GdprConcern
  before_action :check_if_authenticated, only: [:create, :missing]

  def show
    @consent = Consent.where(kind: params[:kind], active: true).first
  end

  def missing
    @consents = Consent.where(id: missing_consent_ids(gdpr_resource))
  end

  def create
    consents = Consent.where(id: params[:consent_ids])
    resource = gdpr_resource

    if consents.none? || missing_consent_ids(resource).difference(consents.ids).any?
      redirect_to missing_consents_path, alert: I18n.t('gdpr.controllers.create_error')
      return
    end

    consents.each do |consent|
      AcceptedConsent.create!(acceptable: resource, consent: consent, ip: request.remote_ip)
    end

    if user_signed_in?
      redirect_to user_root_path
    else
      redirect_to root_path
    end
    # rescue
    #   redirect_to missing_consents_path, alert: 'Something went wrong'
  end
  # app/controllers/consents_controller.rb
  def accept_cookies
    @consent = Consent.where(kind: Consent::COOKIES, active: true).first
    cookies[:cookies_accepted] = {
      value: @consent.version,
      secure: Rails.env.production?,
      same_site: Rails.env.production? ? :none : :lax,
      httponly: false # This cookie needs to be readable by JS
    }

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(:accept_cookies) }
    end
  rescue StandardError
    render turbo_stream: turbo_stream.toast(I18n.t('gdpr.controllers.accept_cookies_error'), type: 'alert')
  end

  private

  def check_if_authenticated
    redirect_to root_path, status: :unauthorized if gdpr_resource.blank?
  end

end
