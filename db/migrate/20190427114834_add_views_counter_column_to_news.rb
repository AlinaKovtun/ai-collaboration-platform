# frozen_string_literal: true

class AddViewsCounterColumnToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :views, :integer, default: 0
  end
end
