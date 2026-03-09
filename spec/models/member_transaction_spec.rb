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
require 'rails_helper'

RSpec.describe MemberTransaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
