# == Schema Information
#
# Table name: budget_units
#
#  id                 :uuid             not null, primary key
#  max_amount_cents   :integer          default(0), not null
#  spent_amount_cents :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  budget_id          :uuid             not null
#  category_id        :uuid             not null
#
# Indexes
#
#  index_budget_units_on_budget_id    (budget_id)
#  index_budget_units_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :budget_unit do
    
  end
end
