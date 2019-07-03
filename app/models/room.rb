class Room < ApplicationRecord
  include AASM
  include PgSearch
  attr_accessor :delete_photos
  mount_uploaders :photos, PhotoUploader
  has_many :meetings
  belongs_to :zone
  belongs_to :user
  belongs_to :category
  has_one :city, through: :zone

  # Fields validation
  validates_presence_of :title
  validates_presence_of :description

  # Search scopes
  pg_search_scope :full_search, against: [
                                  :title,
                                  :description,
                                ],
                                associated_against: {
                                  city: :name,
                                  zone: :name,
                                },
                                order_within_rank: "promoted ASC",
                                using: [
                                  :tsearch,
                                  :trigram,
                                ]

  ##########
  # States #
  ##########
  # Publication state
  aasm column: "state" do
    state :published, initial: true
    state :draft
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
  after_validation do
    uploaders = photos.delete_if do |uploader|
      if Array(delete_photos).include?(uploader.file.identifier)
        uploader.remove!
        true
      end
    end
    write_attribute(:photos, uploaders.map { |uploader| uploader.file.identifier })
  end

  rails_admin do
    edit do
      include_all_fields
      exclude_fields :photos
      field :photos, :multiple_carrierwave
    end
  end
end
