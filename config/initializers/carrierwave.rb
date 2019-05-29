# frozen_string_literal: true

require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIATNWO3S3YWW5UXFGL',
    aws_secret_access_key: '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',
    region: 'us-east-2',
    path_style: true
  }
  config.fog_directory  = 'dark-side'
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
