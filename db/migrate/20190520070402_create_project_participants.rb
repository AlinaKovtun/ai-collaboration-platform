# frozen_string_literal: true

class CreateProjectParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :project_participants do |t|
      t.references :user, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
