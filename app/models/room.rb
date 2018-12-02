class Room < ApplicationRecord
  include AASM
  attr_accessor :remove_photos

  belongs_to :user
  belongs_to :zone
  has_many :meetings
  belongs_to :category
  has_one :city, through: :zone
  has_many_attached :photos

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description

  ##########
  # States #
  ##########
  # Publication state
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

  # Promotion state
  aasm column: "promoted" do
    state :none, initial: true
    state :silver
    state :gold

    event :to_silver do
      transitions to: :silver
    end

    event :to_gold do
      transitions to: :gold
    end

    event :to_none do
      transitions to: :none
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
