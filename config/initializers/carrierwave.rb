# frozen_string_literal: true

require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', 'test'),
    aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', 'test'),
    region: ENV.fetch('AWS_REGION', 'test'),
    path_style: true
  }
  if Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_directory  = ENV.fetch('AWS_BUCKET', 'test')
    config.fog_public     = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end
