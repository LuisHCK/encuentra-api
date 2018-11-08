class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :price, :lat, :lng, :state, :photos, :address, :currency

  belongs_to :user
  belongs_to :zone
  belongs_to :category
  has_one :city

  attribute :photos do |object|
    if object.photos.attached?
      p = []
      object.photos.each do |photo|
        p.push(Rails.application.routes.url_helpers.rails_blob_url(photo))
      end
      p
    else
      [Rails.application.default_url_options[:host] + "/assets/room_default_cover.jpeg"]
    end
  end
end
