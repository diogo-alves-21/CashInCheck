# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :uuid             not null
#
# Indexes
#
#  index_categories_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class Category < ApplicationRecord

  belongs_to :group

  has_many :transactions, dependent: :destroy

  has_many :budgets, dependent: :destroy

  has_many :entity_categories, dependent: :destroy
  has_many :entities, through: :entity_categories

  validates :name, presence: { with: true, message: "Nome não pode ficar em branco" }, length: { maximum: 50 }

  default_scope { order(Arel.sql('LOWER(name) ASC')) }

end
