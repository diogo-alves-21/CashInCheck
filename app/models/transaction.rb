# == Schema Information
#
# Table name: transactions
#
#  id                 :uuid             not null, primary key
#  amount_cents       :integer          default(0), not null
#  amount_currency    :string           default("EUR"), not null
#  description        :text             default("")
#  entity_name        :string
#  executed_at        :date             not null
#  from_api           :boolean          default(FALSE), not null
#  kind               :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  api_transaction_id :string
#  category_id        :uuid
#  entity_id          :string
#  payer_id           :uuid
#  wallet_id          :uuid             not null
#
# Indexes
#
#  index_transactions_on_category_id  (category_id)
#  index_transactions_on_payer_id     (payer_id)
#  index_transactions_on_wallet_id    (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (payer_id => members.id)
#  fk_rails_...  (wallet_id => base_wallets.id)
#
class Transaction < ApplicationRecord

  # has_and_belongs_to_many :payees, class_name: "Member", join_table: "members_transactions", association_foreign_key: "payee_id", foreign_key: "transaction_id"
  # has_and_belongs_to_many :tags

  has_many :member_transactions, dependent: :destroy
  has_many :payees, through: :member_transactions, source: :member

  has_many :tag_transactions, dependent: :destroy
  has_many :tags, through: :tag_transactions

  belongs_to :payer, class_name: "Member", optional: true
  belongs_to :base_wallet, foreign_key: :wallet_id, class_name: "BaseWallet"
  belongs_to :category, optional: true

  after_create :add_amount_wallet
  after_create :increment_budgets
  after_update :update_budgets, if: :saved_change_to_amount_cents?
  after_update :update_amount_wallet
  after_update :handle_kind_change, if: :saved_change_to_kind?
  after_update :handle_category_change, if: :saved_change_to_category_id?
  after_destroy :remove_amount_wallet

  enum :kind, { "Rendimento" => 0, "Despesa" => 1 }

  monetize :amount_cents, with_model_currency: :amount_currency

  validates :kind, presence: true
  validates :executed_at, presence: true
  validates :description, length: { maximum: 255 }
  validates :amount_cents, presence: true

  scope :search, ->(search_param) {
    joins(<<-SQL.squish)
      LEFT JOIN members      AS payers      ON payers.id      = transactions.payer_id
      LEFT JOIN member_transactions       ON member_transactions.transaction_id = transactions.id
      LEFT JOIN members      AS payees      ON payees.id      = member_transactions.payee_id
    SQL
      .where("payers.name ILIKE :search OR payees.name ILIKE :search", search: "%#{search_param}%")
      .distinct
  }

  def amount_with_currency(amount)
    format = I18n.t :format, scope: 'number.currency.format'
    Money.from_cents(amount, amount_currency).format(format: format)
  end

  def formated_date(date)
    date.strftime("%d-%m-%Y")
  end

  def sign_for_amount
    amount_with_currency(Despesa? ? -amount_cents : amount_cents)
  end

  private

  def increment_budgets
    Budgets::TransactionBudgetUpdater.new(self, operation: :add).call
  end

  def decrease_budgets
    Budgets::TransactionBudgetUpdater.new(self, operation: :remove).call
  end

  def update_budgets
    Budgets::TransactionBudgetUpdater.new(self, operation: :update).call
  end

  def handle_kind_change
    old_kind, new_kind = saved_change_to_kind
    Budgets::TransactionBudgetUpdater.new(self, operation: (new_kind == "Despesa" ? :add : :remove)).call
  end

  def handle_category_change
    old_cat, new_cat = saved_change_to_category_id
    Budgets::TransactionBudgetUpdater.new(self, operation: :remove, category: Category.find(old_cat)).call
    return unless Despesa?

    Budgets::TransactionBudgetUpdater.new(self, operation: :add, category: new_cat).call
  end

  def add_amount_wallet
    delta = Despesa? ? -amount_cents : amount_cents
    if base_wallet.type == "Wallet"
      base_wallet.update!(balance_cents: base_wallet.balance_cents + delta)
    else
      base_wallet.update!(current_amount_cents: base_wallet.current_amount_cents + delta)
    end
  end

  def remove_amount_wallet
    delta = Despesa? ? amount_cents : -amount_cents
    if base_wallet.type == "Wallet"
      base_wallet.update!(balance_cents: base_wallet.balance_cents + delta)
    else
      base_wallet.update!(current_amount_cents: base_wallet.current_amount_cents + delta)
    end
  end

  def update_amount_wallet
    return unless base_wallet.type == "Wallet"

    old_amount = attribute_before_last_save(:amount_cents)
    old_kind   = attribute_before_last_save(:kind)

    old_direction = old_kind == "Despesa" ? -1 : 1
    new_direction = kind == "Despesa" ? -1 : 1

    delta = (-old_direction * old_amount) + (new_direction * amount_cents)
    apply_wallet_delta(delta)
  end

  def apply_wallet_delta(delta)
    base_wallet.update!(balance_cents: base_wallet.balance_cents + delta)
  end

end
