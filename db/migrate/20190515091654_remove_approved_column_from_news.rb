# frozen_string_literal: true

class RemoveApprovedColumnFromNews < ActiveRecord::Migration[5.2]
  def change
    remove_column :news, :approved
  end
end
