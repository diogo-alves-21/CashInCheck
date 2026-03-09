# == Schema Information
#
# Table name: entity_tags
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  api_entity_id :string           not null
#  group_id      :uuid             not null
#  tag_id        :uuid             not null
#
# Indexes
#
#  index_entity_tags_on_api_entity_id_and_group_id  (api_entity_id,group_id) UNIQUE
#  index_entity_tags_on_group_id                    (group_id)
#  index_entity_tags_on_tag_id                      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe EntityTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
