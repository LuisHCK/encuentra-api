class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  process resize_to_fit: [800, 80000]
  process :quality => 75

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [200, 10000]
    process :quality => 75
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url(*args)
    "/assets/" + [version_name, "room_default_cover.jpeg"].compact.join("_")
  end
end
