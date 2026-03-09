# == Schema Information
#
# Table name: budgets
#
#  id               :uuid             not null, primary key
#  currency         :string           default("EUR"), not null
#  description      :text
#  max_amount_cents :integer          default(0), not null
#  name             :string(50)       not null
#  status           :integer          default("on_going"), not null
#  unit             :integer          default("monthly"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :uuid             not null
#  group_id         :uuid             not null
#  wallet_id        :uuid             not null
#
# Indexes
#
#  index_budgets_on_category_id  (category_id)
#  index_budgets_on_group_id     (group_id)
#  index_budgets_on_wallet_id    (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (wallet_id => base_wallets.id)
#
FactoryBot.define do
  factory :budget do

  end
end
