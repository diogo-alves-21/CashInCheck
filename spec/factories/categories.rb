# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :uuid             not null
#
# Indexes
#
#  index_categories_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
FactoryBot.define do
  factory :category do
    
  end
end
