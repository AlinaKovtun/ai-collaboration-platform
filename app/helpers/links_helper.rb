# frozen_string_literal: true

module LinksHelper
  def links_helper(obj)
    link_to obj.user.full_name, user_path(obj.user.id), class: 'text-dark'
  end
end
