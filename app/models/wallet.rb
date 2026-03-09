# == Schema Information
#
# Table name: base_wallets
#
#  id                   :uuid             not null, primary key
#  api_access_token     :string
#  balance_cents        :integer          default(0), not null
#  balance_currency     :string           default("USD"), not null
#  currency             :string           default("EUR"), not null
#  current_amount_cents :integer          default(0), not null
#  description          :text             default(""), not null
#  end_date             :date
#  name                 :string(50)       not null
#  start_date           :date
#  status               :integer          default(0), not null
#  target_amount_cents  :integer          default(0), not null
#  type                 :string           default("Wallet")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :string
#  group_id             :uuid             not null
#
# Indexes
#
#  index_base_wallets_on_api_access_token  (api_access_token)
#  index_base_wallets_on_group_id          (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class Wallet < BaseWallet

  # == Includes =============================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================
  monetize :balance_cents, with_model_currency: :balance_currency

  # == Relationships ========================================================
  has_many :budgets, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================
  after_update :sync_transactions

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  private

  def sync_transactions
    return unless account_id.present? && saved_change_to_account_id?

    OpenApiSyncTransactions.perform_later(id)
  end

end
