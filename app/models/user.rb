# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string(100)      not null
#  encrypted_password     :string           not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, invite_for: 2.weeks

  has_one :member, dependent: :destroy

  after_create :create_first_group

  attr_accessor :invited_to_group_id

  validates :email, presence: { with: true, message: "Este campo é obrigatório" }, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_required?

  accepts_nested_attributes_for :member

  def password_required?
    new_record? || password.present?
  end

  def create_first_group
    group = self.member.groups.create!(name: "My Group")
    group.group_members[0].update!(role: 1)

    category_names = ["Health", "House", "Services", "Income", "Lifestyle", "Education", "Essentials", "Other"]

    category_names.map do |name|
      Category.create!(name: name, group_id: group.id)
    end

    group.wallets.create!(name: "My Wallet", description: "My first wallet")
  end

end
