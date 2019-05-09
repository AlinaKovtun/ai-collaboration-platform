# frozen_string_literal: true

class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :event_start
      t.datetime :event_end
      t.float :cost, default: 0
      t.string :venue
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
