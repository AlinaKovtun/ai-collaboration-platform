# frozen_string_literal: true

class AddAasmStateToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :state, :string
  end
end
