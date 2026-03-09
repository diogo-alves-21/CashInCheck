class GeneralPagesController < ApplicationController

  def template; end

  def more_menu
    max_info = 5

    @groups = current_user.member.groups
    @more_groups = @groups.count > max_info
    @groups = @groups.limit(max_info)
  end

  def index
    return unless user_signed_in?

    @spending_by_category_per_group = {}
    @spending_by_tag_per_group = {}
    @goal_progress_per_group = {}
    @goal_donuts_per_group = {}
    @monthly_budget_variation_per_group = {}
    @annual_budget_variation_per_group = {}

    selected_group_id = params[:group_id].presence
    @selected_group = current_user.member.groups.find_by(id: selected_group_id) if selected_group_id

    groups_to_process = if @selected_group
      [@selected_group]
    else
      current_user.member
                  .groups
                  .includes(:budgets)
    end

    groups_to_process.each do |group|
      spending_category = Transaction
                          .joins(:base_wallet, :category)
                          .where(kind: 'Despesa', base_wallets: { group: group })
                          .group("categories.name")
                          .sum(:amount_cents)
                          .transform_values { |cents| Money.from_cents(cents, "EUR").to_f }

      @spending_by_category_per_group[group.name] = spending_category

      spending_tag = Transaction
                     .joins(:base_wallet, :tags)
                     .where(kind: 'Despesa', base_wallets: { group: group })
                     .group("tags.name")
                     .sum(:amount_cents)
                     .transform_values { |cents| Money.from_cents(cents, "EUR").to_f }

      @spending_by_tag_per_group[group.name] = spending_tag

      # goals = group.goals
      # @goal_progress_per_group[group.name] = [
      # {
      #   name: "Meta",
      #   data: goals.map { |goal| [goal.name, goal.target_amount.to_f] }.to_h
      # },
      # {
      #   name: "Atual",
      #   data: goals.map { |goal| [goal.name, goal.current_amount.to_f] }.to_h
      # }
      # ]

      @goal_donuts_per_group[group.name] = group.goals.where(status: :in_progress).map do |goal|
        current = goal.current_amount.to_f
        target = goal.target_amount.to_f
        percent = target > 0 ? ((current / target) * 100).round : 0
        percent = 100 if percent > 100

        {
          name: goal.name,
          percent: percent
        }
      end

      group.budgets.map do |budget|
        units = budget.budget_units

        if budget.monthly_unit?

          filtered_units = units.where("created_at >= ?", 12.months.ago.beginning_of_month)
          data = filtered_units
                 .group_by { |unit| unit.created_at.beginning_of_month }
                 .transform_keys { |date| date.strftime("%b %Y") }
                 .transform_values { |units| Money.from_cents(units.sum(&:spent_amount_cents), "EUR").to_f }

          @monthly_budget_variation_per_group[group.name] ||= []
          @monthly_budget_variation_per_group[group.name] << {
            name: budget.name,
            data: data.sort.to_h
          }

        elsif budget.annual_unit?
          filtered_units = units.where("created_at >= ?", 5.years.ago.beginning_of_year)
          data = filtered_units
                 .group_by { |unit| unit.created_at.beginning_of_year }
                 .transform_keys { |date| date.strftime("%Y") }
                 .transform_values { |units| Money.from_cents(units.sum(&:spent_amount_cents), "EUR").to_f }

          @annual_budget_variation_per_group[group.name] ||= []
          @annual_budget_variation_per_group[group.name] << {
            name: budget.name,
            data: data.sort.to_h
          }
        end
      end
    end

    @top_transfers = Transaction
                     .includes(:base_wallet)
                     .where(base_wallets: { group: current_user.member.groups })
                     .order(amount_cents: :desc)
                     .limit(10)

    @top_merchants = Transaction
                     .includes(:base_wallet)
                     .where(base_wallets: { group: current_user.member.groups })
                     .group(:entity_name)
                     .sum(:amount_cents)
                     .sort_by { |_entity, total| -total }
                     .first(10)

    @expense_and_income_comparison = [
      { name: "Rendimento", data: monthly_totals("Rendimento") },
      { name: "Despesa",    data: monthly_totals("Despesa") }
    ]
  end

  private

  def monthly_totals(kind)
    Transaction
      .joins(:base_wallet)
      .where(kind: kind, base_wallets: { group_id: current_user.member.group_ids })
      .where("transactions.executed_at >= ?", 12.months.ago.beginning_of_month)
      .group("DATE_TRUNC('month', transactions.executed_at)")
      .sum(:amount_cents)
      .transform_keys { |month| month.to_date.strftime("%b %Y") }
      .transform_values { |cents| Money.from_cents(cents, "EUR").to_f }
  end

end
