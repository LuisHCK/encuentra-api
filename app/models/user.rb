class User < ApplicationRecord
  rolify

  # Necessary to authenticate

  has_secure_password

  # Now Using activestorage instead CarrierWave
  # mount_uploader :avatar, AvatarUploader
  has_one_attached :avatar

  # Basic password validation
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  before_validation {
    (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase)
  }

  # Fields validation
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  # validates_presence_of :dni
  validates_uniqueness_of :username

  def can_update_user?(user_id)
    id.to_s == user_id.to_s
  end
end
