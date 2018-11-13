class CategorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :code, :image_url

  def image_url
    variant = object.image.variant(resize: "118x96")
    return rails_representation_url(variant, only_path: true)
  end
end
