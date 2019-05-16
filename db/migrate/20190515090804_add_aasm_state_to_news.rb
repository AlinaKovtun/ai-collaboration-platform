# frozen_string_literal: true

class AddAasmStateToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :aasm_state, :string
  end
end
