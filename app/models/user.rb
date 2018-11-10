class User < ApplicationRecord
  attr_accessor :remove_avatar
  after_create :assign_default_role
  rolify

  # Necessary to authenticate
  has_secure_password

  # Relationships
  has_many :rooms

  # Now Using activestorage instead CarrierWave
  # mount_uploader :avatar, AvatarUploader
  has_one_attached :avatar

  # Basic password validation
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  # validates_confirmation_of :password, allow_nil: true, allow_blank: false

  before_validation {
    (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase)
  }

  # Fields validation
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  # validates_presence_of :dni
  validates_uniqueness_of :username
  validates_presence_of :name
  validates_presence_of :lastname
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true

  def can_update_user?(user_id)
    id.to_s == user_id.to_s
  end

  def assign_default_role
    self.add_role(:publisher)
  end

  # Rails admin config

  after_save do
    # the has_one
    avatar.purge if remove_avatar == "1"
  end

  rails_admin do
    configure :set_password
    create do
      include_all_fields
      exclude_fields :password_digest, :avatar
      include_fields :set_password
      field :avatar, :active_storage
    end
    edit do
      include_fields :set_password
      include_all_fields
      exclude_fields :password_digest, :avatar
      field :avatar, :active_storage
    end
  end

  # Provided for Rails Admin to allow the password to be reset
  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end
end
