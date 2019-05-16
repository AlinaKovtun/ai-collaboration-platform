# frozen_string_literal: true

class News < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, as: :commentable

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :short_information, presence: true, length: { maximum: 200 }

  scope :approved, -> { where(approved: true) }
end
