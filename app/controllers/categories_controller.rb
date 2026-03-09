class CategoriesController < ApplicationController

  before_action :set_group

  def index
    @categories = @group.categories

    respond_to do |format|
      format.html
      format.json { render json: @categories.select(:id, :name) }
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @group.categories << @category
    if @category.save
      redirect_to group_categories_path(@group), notice: "Categoria criada com sucesso!"
    else
      render(:new)
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to group_categories_path(@group), notice: "Categoria atualizada com sucesso!"
    else
      render(:edit)
    end
  end

  private

  def set_group
    @group = current_user.member.groups.find(params[:group_id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
