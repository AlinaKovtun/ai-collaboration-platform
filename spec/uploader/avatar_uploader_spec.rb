# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }

  let(:uploader) { AvatarUploader.new(user, :avatar) }

  let(:uploader_uncorrent_format) { AvatarUploader.new(user, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open('spec/test3.jpeg') { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be exactly 150 by 150 pixels' do
      expect(uploader.thumb).to have_dimensions(150, 150)
    end
  end

  it 'has the correct format' do
    expect(uploader).to be_format('JPEG')
  end
end
