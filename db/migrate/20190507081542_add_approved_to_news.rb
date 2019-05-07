# frozen_string_literal: true

class AddApprovedToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :approved, :boolean, default: false
  end
end
