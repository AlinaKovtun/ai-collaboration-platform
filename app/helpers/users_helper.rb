# frozen_string_literal: true

module UsersHelper
  def link_to_user(user)
    link_to user.full_name, user_path(user), class: 'text-dark'
  end
end
