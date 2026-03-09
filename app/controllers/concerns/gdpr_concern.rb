module GdprConcern
  extend ActiveSupport::Concern

  def gdpr!
    check_gdpr(gdpr_resource, missing_consents_path)
  end

  def missing_consent_ids(resource)
    consents = Consent.where(kind: Consent::REQUIRED_CONSENTS, active: true)
    return [] if consents.blank?

    consent_ids = []
    consent_kinds = []
    consents.each do |consent|
      if consent_kinds.exclude?(consent.kind)
        consent_ids << consent.id
        consent_kinds << consent.kind
      end
    end

    end_date = Time.current.end_of_day
    start_date = (end_date - 1.year).beginning_of_day
    accepted_consents = resource.accepted_consents.where(consent_id: consent_ids, created_at: start_date..end_date)

    consent_ids - accepted_consents.pluck(:consent_id)
  end

  private

  def check_gdpr(resource, fail_path)
    redirect_to fail_path if missing_consent_ids(resource).present?
  end

  def gdpr_resource
    # if user_signed_in?
    current_user
    # elsif
    # end
  end
end
