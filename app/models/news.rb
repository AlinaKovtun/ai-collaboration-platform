# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :short_information, presence: true, length: { maximum: 200 }
end
