# == Schema Information
#
# Table name: groups
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord

  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members

  has_many :entity_categories, dependent: :destroy
  has_many :entities_per_category, through: :entity_categories

  has_many :entity_tags, dependent: :destroy
  has_many :entities_per_group, through: :entity_tags

  has_many :base_wallets, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :budgets, dependent: :destroy

  validates :name, presence: { with: true, message: "Nome não pode ficar em branco" }, length: { maximum: 50 }

  def balance_cents
    wallets.sum(:balance_cents)
  end

end
