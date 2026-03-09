# == Schema Information
#
# Table name: budgets
#
#  id               :uuid             not null, primary key
#  currency         :string           default("EUR"), not null
#  description      :text
#  max_amount_cents :integer          default(0), not null
#  name             :string(50)       not null
#  status           :integer          default("on_going"), not null
#  unit             :integer          default("monthly"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :uuid             not null
#  group_id         :uuid             not null
#  wallet_id        :uuid             not null
#
# Indexes
#
#  index_budgets_on_category_id  (category_id)
#  index_budgets_on_group_id     (group_id)
#  index_budgets_on_wallet_id    (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (wallet_id => base_wallets.id)
#
class Budget < ApplicationRecord

  # == Includes =============================================================
  include TranslateEnum

  # == Constants ============================================================
  UNIT_MONTHLY = 0
  public_constant :UNIT_MONTHLY
  UNIT_ANNUAL = 1
  public_constant :UNIT_ANNUAL
  STATUS_ON_GOING = 0
  public_constant :STATUS_ON_GOING
  STATUS_ARCHIVED = 1
  public_constant :STATUS_ARCHIVED

  # == Attributes ===========================================================
  enum :unit, {
    monthly: UNIT_MONTHLY,
    annual: UNIT_ANNUAL
  }, suffix: true
  translate_enum :unit

  enum :status, {
    on_going: STATUS_ON_GOING,
    archived: STATUS_ARCHIVED
  }, suffix: true
  translate_enum :status

  # == Extensions ===========================================================
  monetize :max_amount_cents

  # == Relationships ========================================================
  belongs_to :category
  belongs_to :group
  belongs_to :wallet
  has_many :budget_units, dependent: :destroy

  # == Validations ==========================================================
  validates :name, presence: true
  validates :unit, presence: true

  # == Scopes ===============================================================
  default_scope { order(:status, :created_at) }

  # after_create :check_transactions
  after_create :create_unit

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  def get_current_unit_spent
    budget_units.order(created_at: :desc).first.spent_amount_cents
  end

  def formated_date(date)
    date.strftime("%d-%m-%Y")
  end

  def amount_with_currency(amount)
    format = I18n.t :format, scope: 'number.currency.format'
    Money.from_cents(amount, currency).format(format: format)
  end

  def remaining_amount_with_currency
    amount_with_currency(max_amount_cents - get_current_unit_spent)
  end

  def spent_amount_with_currency
    amount_with_currency(get_current_unit_spent)
  end

  def max_amount_with_currency
    amount_with_currency(max_amount_cents)
  end

  def start_date
    case unit
    when 'monthly'
      created_at.to_date.beginning_of_month.strftime("%d %b")
    when 'annual'
      created_at.to_date.beginning_of_year.strftime("%b %Y")
    end
  end

  def end_date
    case unit
    when 'monthly'
      created_at.to_date.end_of_month.strftime("%d %b")
    when 'annual'
      created_at.to_date.end_of_year.strftime("%b %Y")
    end
  end

  def amount_percentage
    percentage = get_current_unit_spent * 100 / max_amount_cents
    percentage.clamp(0, 100)
  end

  def progress_bar_color
    percent = (amount_percentage / 100).clamp(0.0, 1.0)

    #  0     0.3      0.5       1
    #  |      |--------|        |
    # blue    - yellow -       red

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

  # == Instance Methods =====================================================
  private

  def create_unit
    budget_units.create!(
      category:          category,
      max_amount_cents:  max_amount_cents
    )
  end

  def color_from_gradient(from_color, to_color, ratio)
    r = from_color.first + ((to_color.first - from_color.first) * ratio)
    g = from_color[1] + ((to_color[1] - from_color[1]) * ratio)
    b = from_color[2] + ((to_color[2] - from_color[2]) * ratio)

    "rgb(#{r.round}, #{g.round}, #{b.round})"
  end

  def gradient_colors
    [
      # [160, 249, 65], # green
      [60, 180, 226], # blue
      [255, 193, 7],  # yellow
      [249, 65, 68]   # red
    ]
  end

end
