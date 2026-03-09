# == Schema Information
#
# Table name: members
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
