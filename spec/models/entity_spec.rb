# == Schema Information
#
# Table name: entities
#
#  id            :uuid             not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  api_entity_id :string           not null
#
# Indexes
#
#  index_entities_on_api_entity_id  (api_entity_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Entity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
