# == Schema Information
#
# Table name: consents
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE), not null
#  kind       :integer          default("terms"), not null
#  version    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Consent < ApplicationRecord

  include TranslateEnum

  # == Constants ============================================================
  TERMS = 0
  public_constant :TERMS
  COOKIES = 1
  public_constant :COOKIES
  PRIVACY = 2
  public_constant :PRIVACY

  REQUIRED_CONSENTS = [0, 2].freeze
  public_constant :REQUIRED_CONSENTS

  # == Attributes ===========================================================
  enum :kind, {
    terms: TERMS,
    cookies: COOKIES,
    privacy: PRIVACY
  }, suffix: true
  translate_enum :kind

  has_rich_text :content

  # == Extensions ===========================================================

  # == Relationships ========================================================
  has_many :accepted_consents, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_create :set_active

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def set_active
    self.version = Time.current.strftime('%Y%jT%H%MZ')
    Consent.where(active: true, kind: kind).update_all(active: false) if active
  end

end
