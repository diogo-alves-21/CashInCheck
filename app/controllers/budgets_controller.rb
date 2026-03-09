class BudgetsController < ApplicationController

  before_action :set_budget, only: [:show, :edit, :update, :destroy, :archive]
  before_action :set_groups, only: [:new, :create, :edit, :update]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @budgets = Budget.where(group: current_user.member.groups).includes(:group).order(name: :asc)
  end

  def show
  end

  def new
    @budget = Budget.new
  end

  def create
    amount = Monetize.parse(budget_params[:max_amount_cents]).fractional

    @budget = Budget.new(budget_params.merge(max_amount_cents: amount))

    respond_to do |format|
      if @budget.save
        format.html { redirect_to budgets_path, notice: I18n.t('controllers.created', model: Budget.model_name.human(count: 1)) }
      else
        @budget = Budget.new
        @groups = current_user.member.groups
        format.html { render :new }
      end
    end
  end

  def edit
    @categories = @budget.group.categories
    @wallets = @budget.group.wallets
  end

  def update
    amount = Monetize.parse(budget_params[:max_amount_cents]).fractional

    @budget.assign_attributes(
      budget_params
        .merge(max_amount_cents: amount)
    )

    respond_to do |format|
      if @budget.save
        format.html { redirect_to budgets_path, notice: I18n.t('controllers.updated', model: Budget.model_name.human(count: 1)) }
      else
        @groups = current_user.member.groups
        @categories = @budget.group.categories
        @wallets = @budget.group.wallets
        format.html { render :edit }
      end
    end
  end

  def destroy
    budget = Budget.find(params[:id])
    budget.destroy

    respond_to do |format| format.html { redirect_to budgets_path, notice: I18n.t('controllers.destroyed', model: Budget.model_name.human(count: 1)) } end
  end

  def archive
    return unless @budget.on_going_status?
    respond_to do |format|
      if @budget.update(status: :archived)
        format.html { redirect_to @budget, notice: t('controllers.updated', model: Budget.model_name.human(count: 1)) }
      else
        format.html { redirect_to @budget, alert: t('controllers.update_error', model: Budget.model_name.human(count: 1)) }
      end
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def set_groups
    @groups = current_user.member.groups
  end

  def set_group
    @group = current_user.member.groups.joins(:budgets).find_by!(budgets: { id: @budget.id })
  end

  def budget_params
    params.require(:budget).permit(:name, :max_amount_cents, :unit, :group_id, :category_id, :wallet_id, :description)
  end
end
