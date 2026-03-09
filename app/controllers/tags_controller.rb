class TagsController < ApplicationController

  before_action :set_group

  def index
    @tags = @group.tags
    @tags = @tags.where("name ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
      format.json { render json: @tags.map { |t| { id: t.id, name: t.name } } }
    end
  end

  def show
  end

  def new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    tag_name = tag_params[:name].strip.downcase.delete(" ")
    tag = @group.tags.where('LOWER(name) = ?', tag_name).first
    if tag.nil? && !tag.eql?(tag_name)
      @tag = Tag.create(name: tag_name)
      if @tag
        @group.tags << @tag
        redirect_to group_tags_path, notice: "Tag criada com sucesso!"
      else
        render :new
      end
    else
      redirect_to new_group_tag_path, alert: "Tag já existe!"
    end
  end

  def update
    @tag = Tag.find(params[:id])
    tag_name = tag_params[:name].strip.downcase
    if @tag.update(name: tag_name)
      redirect_to group_tags_path, notice: "Tag editada com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_group
    @group = current_user.member.groups.find(params[:group_id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
