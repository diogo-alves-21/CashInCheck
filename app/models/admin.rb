# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invited_by_type        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :integer
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_invitation_token      (invitation_token) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
class Admin < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  protected

  def devise_mailer
    DeviseCustomMailer
  end

end
