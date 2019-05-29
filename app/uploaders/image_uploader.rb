# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.test? or Rails.env.cucumber?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/assets/' + [version_name, 'default.png'].compact.join('_')
  end

  version :thumb do
    process resize_to_fit: [150, 150]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
