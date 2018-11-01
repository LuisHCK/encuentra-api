class Meeting < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :room
  has_one :host, through: :room, source: :user

  # Validations
  validates_presence_of :date_time

  # States
  aasm column: "state" do
    state :pending, initial: true
    state :accepted
    state :rejected
    state :finished

    event :to_accepted do
      transitions from: :pending, to: :accepted
    end

    event :to_rejected do
      transitions from: [:pending, :accepted], to: :rejected
    end

    event :to_finished do
      transitions from: :accepted, to: :finished
    end
  end
end
