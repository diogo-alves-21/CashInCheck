module TransactionsConcern
  extend ActiveSupport::Concern

  def get_wallet_transactions(wallet)
    scope = filtered_transactions(wallet.transactions)

    month = parsed_month(params[:month], params[:month_navigation])
    params[:month] = month.strftime("%b %Y")

    scope.where(executed_at: month.all_month)
  end

  private

  def filtered_transactions(scope)
    scope = scope.includes(:category, :tags)
                 .order(executed_at: :desc, created_at: :desc)

    scope = scope.where(kind: params[:kind]) if params[:kind].present?
    scope = scope.where(category_id: params[:category_id]) if params[:category_id].present?
    scope = scope.includes(:tags).where(tags: { id: params[:tag_id] }) if params[:tag_id].present?
    scope = scope.search(params[:query]) if params[:query].present?

    scope
  end

  def parsed_month(month_param, nav)
    month = month_param.present? ? Date.parse(month_param, "%b %Y") : Time.current
    case nav
    when "prev"
      month.prev_month
    when "next"
      month.next_month
    else
      month
    end
  end
end
