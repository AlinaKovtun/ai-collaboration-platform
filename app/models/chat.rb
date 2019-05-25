# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { maximum: 150 }
  default_scope { order(created_at: :desc) }
end
