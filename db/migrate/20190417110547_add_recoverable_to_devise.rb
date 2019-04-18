# frozen_string_literal: true

class AddRecoverableToDevise < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |u|
      u.string   :reset_password_token
      u.datetime :reset_password_sent_at
    end
    add_index :users, :reset_password_sent_at, unique: true
  end
end
