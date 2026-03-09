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
#  status               :integer          default("scheduled"), not null
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
require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
