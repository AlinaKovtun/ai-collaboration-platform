# frozen_string_literal: true

class CreateEmailChangeRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :email_change_requests do |t|
      t.string :email
      t.string :token
      t.index :token, unique: true

      t.timestamps
    end
  end
end
