# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |u|
      u.string   :confirmation_token
      u.datetime :confirmed_at
      u.datetime :confirmation_sent_at
      u.string   :unconfirmed_email
    end
    add_index :users, :confirmation_token, unique: true
  end
end
