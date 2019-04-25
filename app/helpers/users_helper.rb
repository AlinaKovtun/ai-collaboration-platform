# frozen_string_literal: true

module UsersHelper
  def show_avatar
    current_user.avatar? ? current_user.avatar.thumb.url : current.avatar.default_url
  end
end
