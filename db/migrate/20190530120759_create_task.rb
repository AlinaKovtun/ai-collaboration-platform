class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :short_information
      t.datetime :created_at
      t.boolean :completed, default: false
      t.references :project, foreign_key: true
    end
  end
end
