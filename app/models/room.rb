class Room < ApplicationRecord
  include AASM
  attr_accessor :remove_photos

  belongs_to :user
  belongs_to :zone
  has_many :meetings
  belongs_to :category
  has_one :city, through: :zone
  has_many_attached :photos
  has_many :services

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description

  # States
  aasm column: "state" do
    state :draft, initial: true
    state :published
    state :rented

    event :to_published do
      transitions from: :draft, to: :published
    end

    event :to_rented do
      transitions from: :published, to: :rented
    end

    event :to_draft do
      transitions from: [:published, :rented], to: :draft
    end
  end

  # For rails admin
  after_save do
    Array(remove_photos).each { |id| photos.find_by_id(id).try(:purge) }
  end

  rails_admin do
    edit do
      include_all_fields
      exclude_fields :photos
      field :photos, :multiple_active_storage
    end
  end
end
