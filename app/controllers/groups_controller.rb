class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def index
    @groups = current_user.member.groups.includes(:group_members)

    @ownerships = @groups.each_with_object({}) do |group, hash|
      group_member = group.group_members.find { |gm| gm.member_id == current_user.member.id }
      hash[group.id] = group_member.owner?
    end
  end

  def show
    @owner = @group.group_members.find { |gm| gm.member_id == current_user.member.id }&.owner?

    max_info = 3

    @categories = @group.categories
    @more_categories = @categories.count > max_info
    @categories = @categories.limit(max_info)

    @tags = @group.tags
    @more_tags = @tags.count > max_info
    @tags = @tags.limit(max_info)

    @members = @group.members
    @more_members = @members.count > max_info
    @members = @members.limit(max_info)
  end

  def new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.create(group_params)
    if @group.persisted?
      current_user.member.group_members.create!(group: @group, role: 1)
      redirect_to groups_path, notice: "Grupo criado com sucesso!"
    else
      render(:new)
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "Grupo editado com sucesso!"
    else
      render(:edit)
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: "Grupo apagado com sucesso!"
  end

  private

  def set_group
    @group = current_user.member.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
