# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :news

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 10, maximum: 150 }
  default_scope { order(name: :asc) }
end
