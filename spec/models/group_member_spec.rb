# == Schema Information
#
# Table name: group_members
#
#  id        :uuid             not null, primary key
#  role      :integer          default("regular"), not null
#  group_id  :uuid             not null
#  member_id :uuid             not null
#
# Indexes
#
#  index_group_members_on_group_id   (group_id)
#  index_group_members_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (member_id => members.id)
#
require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
