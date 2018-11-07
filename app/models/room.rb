class Room < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :zone

  has_many :meetings

  has_many_attached :photos

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description

  has_and_belongs_to_many :categories

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
end
