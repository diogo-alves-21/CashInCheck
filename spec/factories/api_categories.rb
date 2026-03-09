# == Schema Information
#
# Table name: api_categories
#
#  id             :uuid             not null, primary key
#  api_identifier :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :uuid             not null
#
# Indexes
#
#  index_api_categories_on_api_identifier  (api_identifier) UNIQUE
#  index_api_categories_on_category_id     (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :api_category do
    
  end
end
