# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'
require 'spec_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }

  let(:user_with_avatar) do
    create(:user, avatar: Rack::Test::UploadedFile.new(
      'spec/test3.jpeg', 'image/jpeg'
    ))
  end

  before { sign_in user }

  describe '#user_avatar_url default url' do
    it 'show default avatar url' do
      expect(helper.user_avatar_url).to eq(user.avatar.default_url)
    end
  end

  describe '#user_avatar_url thumb url' do
    it 'show thumb avatar url' do
      sign_in user_with_avatar
      expect(helper.user_avatar_url).to eq(user_with_avatar.avatar.thumb.url)
    end
  end
end
