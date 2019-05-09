# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
