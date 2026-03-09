class GoalsController < ApplicationController

  before_action :set_goal, only: [:show, :edit, :update, :destroy, :update_amount, :cancel]
  before_action :set_groups, only: [:new, :edit, :create, :update]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  include TransactionsConcern

  def index
    @goals = Goal.where(group: current_user.member.groups).order(name: :asc)
  end

  def show
    @categories = @goal.group.categories.all
    @tags = @goal.group.tags.all
    @transactions = get_wallet_transactions(@goal)

    @currency = @goal.currency
  end

  def new
    @goal = Goal.new
  end

  def edit
  end

  def create
    amount = Monetize.parse(goal_params[:target_amount_cents])

    status = check_date(goal_params[:start_date])

    @goal = Goal.new(goal_params.merge(target_amount_cents: amount.fractional, status: status))

    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path, notice: I18n.t('controllers.created', model: Goal.model_name.human(count: 1)) }
      else
        @goal = Goal.new
        @groups = current_user.member.groups
        format.html { render :new }
      end
    end
  end

  def update
    amount = Monetize.parse(goal_params[:target_amount_cents])

    @goal.assign_attributes(
      goal_params
        .merge(target_amount_cents: amount.fractional)
    )

    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path, notice: I18n.t('controllers.updated', model: Goal.model_name.human(count: 1)) }
      else
        @groups = current_user.member.groups
        format.html { render :edit }
      end
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy

    respond_to do |format|
      format.html { redirect_to goals_path, notice: I18n.t('controllers.destroyed', model: Goal.model_name.human(count: 1)) }
    end
  end

  def update_amount
    amount = Monetize.parse(params[:goal][:current_amount_cents]).fractional
    delta = params[:add].present? ? amount : -amount

    if delta.positive?
      val = @goal.current_amount_cents + delta
      if val > @goal.target_amount_cents

        diff = delta - (val - @goal.target_amount_cents)
        Transaction.create!(kind: 0, wallet_id: @goal.id, amount_cents: diff, executed_at: Date.current)
      else
        Transaction.create!(kind: 0, wallet_id: @goal.id, amount_cents: delta, executed_at: Date.current)
      end
    end

    if delta.negative?
      val = @goal.current_amount_cents + delta

      if val < 0

        diff = (delta - val) * -1
        Transaction.create!(kind: 1, wallet_id: @goal.id, amount_cents: diff, executed_at: Date.current)
      else
        Transaction.create!(kind: 1, wallet_id: @goal.id, amount_cents: delta * -1, executed_at: Date.current)
      end
    end

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: "Valor atualizado com sucesso.", model: Goal.model_name.human(count: 1) }
      else
        format.html { redirect_to @goal, alert: "Erro ao atualizar o valor." }
      end
    end
  end

  def cancel
    respond_to do |format|
      if @goal.update(status: :canceled)
        format.html { redirect_to @goal, notice: t('controllers.updated', model: Goal.model_name.human(count: 1)) }
      else
        format.html { redirect_to @goal, alert: t('controllers.update_error', model: Goal.model_name.human(count: 1)) }
      end
    end
  end

  private

  def check_date(date)
    Date.parse(date).future? ? :scheduled : :in_progress
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def set_groups
    @groups = current_user.member.groups
  end

  def set_group
    @group = current_user.member.groups.joins(:goals).find_by!(goals: { id: @goal.id })
  end

  def goal_params
    params.require(:goal).permit(:name, :target_amount_cents, :start_date, :end_date, :description, :group_id)
  end

end
