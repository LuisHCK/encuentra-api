class RoomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id,
             :title,
             :description,
             :price,
             :lat,
             :lng,
             :state,
             :created_at,
             :updated_at,
             :address,
             :currency,
             :photos_urls,
             :city,
             :services,
             :phones

  belongs_to :user
  belongs_to :zone
  belongs_to :category
  has_many :meetings

  def photos_urls
    if object.photos.attached?
      object.photos.map { |p| rails_blob_url(p) }
    else
      return [Rails.application.default_url_options[:host] + "/assets/room_default_cover.jpeg"]
    end
  end
end
