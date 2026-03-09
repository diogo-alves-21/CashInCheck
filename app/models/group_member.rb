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
class GroupMember < ApplicationRecord

  # == Includes =============================================================

  # == Constants ============================================================

  # == Attributes ===========================================================
  enum :role, { regular: 0, owner: 1 }

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :group
  belongs_to :member

  before_destroy :destroy_group_member

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  private
  def destroy_group_member
    if group.members.count <= 1
      group.destroy
    end

    if owner?
      remaining_owners = group.group_members.where(role: :owner).where.not(member_id: member.id)

      if remaining_owners.exists?
        group.members.delete(member)
      else
        new_owner_candidate = group.group_members.where(role: :regular).take

        if new_owner_candidate
          new_owner_candidate.update!(role: :owner)
          group.members.delete(member)
        end
      end
    else
      group.members.delete(member)
    end
  end
end
