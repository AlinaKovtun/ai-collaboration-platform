# frozen_string_literal: true

class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.string :title
      t.text :short_information
      t.references :user, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
