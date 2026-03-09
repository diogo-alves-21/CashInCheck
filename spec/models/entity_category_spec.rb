# == Schema Information
#
# Table name: entity_categories
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  api_entity_id :string           not null
#  category_id   :uuid             not null
#  group_id      :uuid             not null
#
# Indexes
#
#  index_entity_categories_on_api_entity_id_and_group_id  (api_entity_id,group_id) UNIQUE
#  index_entity_categories_on_category_id                 (category_id)
#  index_entity_categories_on_group_id                    (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (group_id => groups.id)
#
require 'rails_helper'

RSpec.describe EntityCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
