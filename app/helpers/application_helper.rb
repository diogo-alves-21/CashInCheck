module ApplicationHelper
  include Pagy::Frontend

  def bottom_nav_active
    return 2 if params[:controller] == 'general_pages' && params[:action] == 'more_menu'

    # rubocop:disable Lint/SymbolConversion
    controller_map = {
      'users/sessions':      1,
      'users/registrations': 1,
      'devise/passwords':    1,
      'groups':              2,
      'tags':                2,
      'members':             2,
      'categories':          2,
      'wallets':             3,
      'transactions':        3,
      'budgets':             4,
      'goals':               5
    }
    # rubocop:enable Lint/SymbolConversion

    controller_map[:"#{params[:controller]}"] || 0
  end

  def bottom_nav_titles(value)
    case value
    when 0
      I18n.t('views.layout_partials.bottom_nav.home')
    when 1
      I18n.t("devise.sessions.new.sign_in")
    when 2
      I18n.t('views.layout_partials.bottom_nav.more')
    when 3
      I18n.t('views.layout_partials.bottom_nav.wallets')
    when 4
      I18n.t('views.layout_partials.bottom_nav.budgets')
    when 5
      I18n.t('views.layout_partials.bottom_nav.goals')
    else
      I18n.t("views.layout_partials.bottom_nav.#{params[:controller]}")
    end
  end

  def money_from_cents(balance_cents, currency)
    format = I18n.t :format, scope: 'number.currency.format'
    Money.from_cents(balance_cents, currency).format(format: format)
  end
end
