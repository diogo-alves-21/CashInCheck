# == Schema Information
#
# Table name: transactions
#
#  id                 :uuid             not null, primary key
#  amount_cents       :integer          default(0), not null
#  amount_currency    :string           default("EUR"), not null
#  description        :text             default("")
#  entity_name        :string
#  executed_at        :date             not null
#  from_api           :boolean          default(FALSE), not null
#  kind               :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  api_transaction_id :string
#  category_id        :uuid
#  entity_id          :string
#  payer_id           :uuid
#  wallet_id          :uuid             not null
#
# Indexes
#
#  index_transactions_on_category_id  (category_id)
#  index_transactions_on_payer_id     (payer_id)
#  index_transactions_on_wallet_id    (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (payer_id => members.id)
#  fk_rails_...  (wallet_id => base_wallets.id)
#
FactoryBot.define do
  factory :transaction do
    
  end
end
