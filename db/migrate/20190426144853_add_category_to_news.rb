# frozen_string_literal: true

class AddCategoryToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :category_id, :int
    add_foreign_key :news, :categories
    add_index :news, :created_at
  end
end
