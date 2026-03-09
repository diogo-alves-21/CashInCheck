# == Schema Information
#
# Table name: accepted_consents
#
#  id              :bigint           not null, primary key
#  acceptable_type :string           not null
#  ip              :inet
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  acceptable_id   :bigint           not null
#  consent_id      :bigint           not null
#
# Indexes
#
#  index_accepted_consents_on_acceptable  (acceptable_type,acceptable_id)
#  index_accepted_consents_on_consent_id  (consent_id)
#
# Foreign Keys
#
#  fk_rails_...  (consent_id => consents.id)
#

class AcceptedConsent < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :consent
  belongs_to :acceptable, polymorphic: true

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
