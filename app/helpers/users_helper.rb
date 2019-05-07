# frozen_string_literal: true

module UsersHelper
  def user_avatar_url
    current_user.avatar? ? current_user.avatar.thumb.url : current_user.avatar.default_url
  end
end
