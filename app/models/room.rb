class Room < ApplicationRecord
  include AASM
  attr_accessor :remove_photos

  belongs_to :user
  belongs_to :zone
  has_many :meetings
  has_many_attached :photos
  has_one :city, through: :zone

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description

  belongs_to :category

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
      field :title
      field :description
      field :price
      field :lat
      field :lng
      field :state
      field :user
      field :zone
      field :address
      field :currency
      field :category
      field :photos, :multiple_active_storage
    end
  end
end
