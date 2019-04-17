# frozen_string_literal: true

REPOSITORY = 'dark-side/ai-collaboration-platform'
COVERAGE_PATH = 'coverage/coverage.json'

namespace :rspec do
  desc 'Collects code coverage and post comment to GitHub'
  task github_coverage: :environment do
    check_env('GITHUB_ACCESS_TOKEN')
    check_env('CI_PULL_REQUEST')

    client = Octokit::Client.new access_token: ENV['GITHUB_ACCESS_TOKEN']

    PULL_REQUEST_URL = ENV['CI_PULL_REQUEST']
    PULL_REQUEST_ID = URI(PULL_REQUEST_URL).path.split('/').last

    coverage = JSON.parse(File.read(COVERAGE_PATH))

    covered_percent = coverage['metrics']['covered_percent'].round(2)
    covered_strength = coverage['metrics']['covered_strength'].round(2)

    comment =
      "**Code Coverage:**\n"\
      "#{emoji(covered_percent)} **#{covered_percent}%** "\
      "covered at **#{covered_strength}** hits/line"

    puts 'Posting comment...'

    client.add_comment(REPOSITORY, PULL_REQUEST_ID, comment)

    puts 'Done!'
  end
end

def emoji(metrics)
  case metrics
  when 80...90
    ':warning:'
  when 90..100
    ':green_heart:'
  else
    ':red_circle:'
  end
end

def check_env(key)
  unless ENV.key?(key)
    puts "Missing #{key} env variable"
    exit
  end

  return unless ENV[key].empty?

  puts "#{key} is not set"
  exit
end
