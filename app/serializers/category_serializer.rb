class CategorySerializer
  include FastJsonapi::ObjectSerializer
  set_type :category
  set_id :id
  attributes :id, :name, :code, :image

  attribute :image do |object|
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.image)
    else
      Rails.application.default_url_options[:host] + "/assets/category_default_image.png"
    end
  end

  has_many :rooms
end
