class CountrySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :iso3, :iso, :numcode, :latitude, :longitude, :flag_img
  has_many :cities

  def flag_img
    if object.flag_img.attached?
      # .processed.service_url
      variant = object.flag_img.variant(resize: "200x200")
      return Rails.application.default_url_options[:host] + rails_representation_url(variant, only_path: true)
    else
      return Rails.application.default_url_options[:host] + "/assets/default_user_icon.png"
    end
  end
end
