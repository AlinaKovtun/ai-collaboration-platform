# frozen_string_literal: true

class CreateUsersEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events_participants, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
    end
  end
end
