# frozen_string_literal: true

class AddRememberCreatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |u|
      u.datetime :remember_created_at
    end
  end
end
