class MembersController < ApplicationController

  before_action :set_group

  def index
    @members = @group.members

    @member = current_user.member.group_members.find_by(group: @group)
  end

  def show
    @member = Member.find(params[:id])
    @current_user_member_group = current_user.member.group_members.find_by(group: @group)
  end

  def new
    @member = Member.new
  end

  def create
    email = params[:member][:user_attributes][:email]
    name = params[:member][:name]

    if email.present? && name.present?
      user = User.find_by(email: email)
      if user
        if user&.member&.groups&.include?(@group)
          redirect_back fallback_location: new_group_member_path, alert: t("views.members.error.this_member_is_already_in_the_group")
        else
          @group.members << user.member
          redirect_back fallback_location: new_group_member_path, notice: t("views.members.create.member_added")
        end
      else
        user = User.invite!({ email: email }, current_user)
        @member = Member.new(member_params)
        @member.user = user
        @group.members << @member if @member.save
        redirect_back fallback_location: new_group_member_path, notice: t("views.members.create.invitation_sent")
      end
    end

    return unless name.present? && !email.present?

    @member = Member.new(member_params)

    if @member.save
      @group.members << @member
      redirect_to group_members_path(@group), notice: t("views.members.create.member_added")
    else
      redirect_back fallback_location: new_group_member_path(@group)
    end
  end

  def remove
    group_member = GroupMember.find_by(group: @group, member_id: params[:id])

    if group_member.destroy
      if @group.members.count.zero?
        redirect_to groups_path, notice: "Grupo eliminado!"
      elsif group_member.member == current_user.member
        redirect_to groups_path, notice: "Saíu do grupo"
      else
        redirect_to group_path(@group), notice: "Membro removido com sucesso!"
      end
    else
      redirect_back fallback_location: group_path(@group), alert: "Não foi possível remover o membro!"
    end
  end

  private

  def set_group
    @group = current_user.member.groups.find(params[:group_id])
  end

  def member_params
    params.require(:member).permit(:name, user_attributes: [:email])
  end

end
