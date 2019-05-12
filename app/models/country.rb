class Country < ApplicationRecord
  attr_accessor :remove_flag_img
  # Associations
  has_many :cities

  has_one_attached :flag_img

  # Fields validation
  validates_presence_of :name
  validates_presence_of :iso
  validates_presence_of :iso3
  validates_uniqueness_of :name
  validates_uniqueness_of :iso
  validates_uniqueness_of :iso3

  after_save do
    # the has_one
    flag_img.purge if remove_flag_img == "1"
  end

  rails_admin do
    create do
      include_all_fields
      field :flag_img, :active_storage
    end
    edit do
      include_all_fields
      field :flag_img, :active_storage
    end
  end
end
