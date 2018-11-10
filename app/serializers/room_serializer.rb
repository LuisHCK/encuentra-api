class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :price, :lat, :lng, :state, :photos, :address, :currency, :days_available, :hours_available, :phones

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

  attribute :days_available do |object|
    begin
      JSON.parse(object.days_available)
    rescue => exception
      []
    end
  end

  attribute :hours_available do |object|
    begin
      JSON.parse(object.hours_available)
    rescue => exception
      []
    end
  end

  attribute :phones do |object|
    begin
      JSON.parse(object.phones)
    rescue => exception
      []
    end
  end
end
