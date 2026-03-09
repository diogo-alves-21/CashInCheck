# == Schema Information
#
# Table name: tag_transactions
#
#  id             :uuid             not null, primary key
#  tag_id         :uuid             not null
#  transaction_id :uuid             not null
#
# Indexes
#
#  index_tag_transactions_on_tag_id          (tag_id)
#  index_tag_transactions_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
class TagTransaction < ApplicationRecord
  # == Includes =============================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :tag
  belongs_to :financial_transaction, class_name: "Transaction", foreign_key: "transaction_id"

  # == Validations ===============================  ===========================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
