# == Schema Information
#
# Table name: base_wallets
#
#  id                   :uuid             not null, primary key
#  api_access_token     :string
#  balance_cents        :integer          default(0), not null
#  balance_currency     :string           default("USD"), not null
#  currency             :string           default("EUR"), not null
#  current_amount_cents :integer          default(0), not null
#  description          :text             default(""), not null
#  end_date             :date
#  name                 :string(50)       not null
#  start_date           :date
#  status               :integer          default("scheduled"), not null
#  target_amount_cents  :integer          default(0), not null
#  type                 :string           default("Wallet")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :string
#  group_id             :uuid             not null
#
# Indexes
#
#  index_base_wallets_on_api_access_token  (api_access_token)
#  index_base_wallets_on_group_id          (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class Goal < BaseWallet

  # == Includes =============================================================
  include TranslateEnum

  # == Constants ============================================================
  STATUS_SCHEDULED = 0
  public_constant :STATUS_SCHEDULED
  STATUS_IN_PROGRESS = 1
  public_constant :STATUS_IN_PROGRESS
  STATUS_ACHIEVED = 2
  public_constant :STATUS_ACHIEVED
  STATUS_FAILED = 3
  public_constant :STATUS_FAILED
  STATUS_CANCELED = 4
  public_constant :STATUS_CANCELED

  STATUS_ORDER = {
    Goal::STATUS_IN_PROGRESS => 0,
    Goal::STATUS_SCHEDULED => 1,
    Goal::STATUS_ACHIEVED => 2,
    Goal::STATUS_FAILED => 2,
    Goal::STATUS_CANCELED => 3
  }.freeze
  public_constant :STATUS_ORDER

  # == Attributes ===========================================================
  enum :status, {
    in_progress: STATUS_IN_PROGRESS,
    scheduled: STATUS_SCHEDULED,
    achieved: STATUS_ACHIEVED,
    failed: STATUS_FAILED,
    canceled: STATUS_CANCELED
  }, suffix: true
  translate_enum :status

  # == Extensions ===========================================================
  monetize :target_amount_cents
  monetize :current_amount_cents

  # == Relationships ========================================================
  belongs_to :group

  # == Validations ==========================================================
  validates :name, presence: true
  validates :target_amount_cents, presence: true

  # == Scopes ===============================================================
  order_clause = STATUS_ORDER.map { |status, index| "WHEN '#{status}' THEN #{index}" }.join(' ')

  default_scope do # rubocop:disable Rails/DefaultScope
    order(
      Arel.sql("CASE status #{order_clause} END"),
      start_date: :asc
    )
  end

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  def formated_date(date)
    date.strftime("%d-%m-%Y")
  end

  def amount_with_currency(amount)
    format = I18n.t :format, scope: 'number.currency.format'
    Money.from_cents(amount, currency).format(format: format)
  end

  # == Instance Methods =====================================================

  def goal_amount_with_currency
    amount_with_currency(target_amount_cents)
  end

  def actual_amount_with_currency
    amount_with_currency(current_amount_cents)
  end

  def remaining_amount_with_currency
    amount_with_currency(target_amount_cents - current_amount_cents)
  end

  def amount_percentage
    percentage = current_amount_cents * 100 / target_amount_cents
    percentage.clamp(0, 100)
  end

  def progress_bar_color
    percent = (amount_percentage / 100).clamp(0.0, 1.0)

    #  0     0.3      0.5       1
    #  |      |--------|        |
    # red     - yellow -       blue

    case percent
    when 0.0..0.3
      ratio = percent / 0.3
      color_from_gradient(gradient_colors.first, gradient_colors[1], ratio)
    when 0.3..0.5
      rgb(gradient_colors[1])
    else
      ratio = (percent - 0.5) / 0.5
      color_from_gradient(gradient_colors[1], gradient_colors.last, ratio)
    end
  end

  private

  def color_from_gradient(from_color, to_color, ratio)
    r = from_color.first + ((to_color.first - from_color.first) * ratio)
    g = from_color[1] + ((to_color[1] - from_color[1]) * ratio)
    b = from_color[2] + ((to_color[2] - from_color[2]) * ratio)

    "rgb(#{r.round}, #{g.round}, #{b.round})"
  end

  def gradient_colors
    [
      [249, 65, 68], # red
      [255, 193, 7], # yellow
      [160, 249, 65] # green
      # [60, 180, 226] # blue
    ]
  end

end
