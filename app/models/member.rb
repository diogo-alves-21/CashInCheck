# == Schema Information
#
# Table name: members
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Member < ApplicationRecord

  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members

  belongs_to :user, optional: true
  accepts_nested_attributes_for :user, reject_if: proc { |attrs| attrs['email'].blank? }

  has_many :member_transactions, foreign_key: "payee_id", dependent: :destroy
  has_many :received_transactions, through: :member_transactions, source: :financial_transaction

  #has_and_belongs_to_many :received_transactions, class_name: "Transaction", join_table: "members_transactions", foreign_key: "payee_id", association_foreign_key: "transaction_id"

  has_many :sent_transactions, class_name: "Transaction", foreign_key: "payer_id", dependent: :destroy

  validates :name, presence: {with: true, message: "Nome não pode ficar em branco"}, length: {maximum: 50}

end
