# frozen_string_literal: true

# rubocop:disable Style/GlobalVars
$redis = Redis.new(url: ENV['REDISTOGO_URL'])
# rubocop:enable Style/GlobalVars
