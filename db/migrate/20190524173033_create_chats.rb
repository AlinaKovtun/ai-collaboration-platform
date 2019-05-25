# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.datetime :created_at

      t.timestamps
    end
  end
end
