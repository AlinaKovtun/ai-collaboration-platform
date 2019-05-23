# frozen_string_literal: true

class AddUserToEmailChangeRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :email_change_requests, :user, foreign_key: true
  end
end
