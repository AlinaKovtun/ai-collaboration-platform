# frozen_string_literal: true

class AddAasmStateToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :state, :string
  end
end
