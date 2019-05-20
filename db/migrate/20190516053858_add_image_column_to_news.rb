# frozen_string_literal: true

class AddImageColumnToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :image, :string
  end
end
