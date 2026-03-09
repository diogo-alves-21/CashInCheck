class Users::InvitationsController < Devise::InvitationsController
=begin
  def update
    super do |user|
      group_id = params[:user][:invited_to_group_id]
      return unless group_id.present?

      group = Group.find_by(id: group_id)
      return unless group

      member = Member.find_by(user_id: user.id)
      if member.present?
        member.groups << group
      end
    end
  end
=end
end
