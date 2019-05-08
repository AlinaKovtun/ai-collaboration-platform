# frozen_string_literal: true

module DeviseOverrides
  class RegistrationsController < Devise::RegistrationsController
    def new
      @visible_roles = Role.visible_to_users
      super
    end
  end
end
