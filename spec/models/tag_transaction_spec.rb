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
require 'rails_helper'

RSpec.describe TagTransaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
