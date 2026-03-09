# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :uuid             not null
#
# Indexes
#
#  index_tags_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class Tag < ApplicationRecord

  belongs_to :group

  has_many :tag_transactions, dependent: :destroy
  has_many :transactions, through: :tag_transactions, source: :financial_transaction

  has_many :entity_tags, dependent: :destroy
  has_many :entities, through: :entity_tags

  # has_and_belongs_to_many :associated_transactions, class_name: 'Transaction', join_table: 'tags_transactions'

  validates :name, presence: { with: true, message: "Nome não pode ficar em branco" }, length: { maximum: 50 }

  default_scope { order(Arel.sql('LOWER(name) ASC')) }

end
