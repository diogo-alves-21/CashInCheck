# == Schema Information
#
# Table name: member_transactions
#
#  id             :uuid             not null, primary key
#  payee_id       :uuid             not null
#  transaction_id :uuid             not null
#
# Indexes
#
#  index_member_transactions_on_payee_id        (payee_id)
#  index_member_transactions_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (payee_id => members.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
class MemberTransaction < ApplicationRecord

  # == Includes =============================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :financial_transaction, class_name: "Transaction", foreign_key: "transaction_id"
  belongs_to :member, class_name: "Member" ,foreign_key: "payee_id"

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
