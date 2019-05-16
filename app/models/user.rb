# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable, :async
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :about_me, length: { maximum: 500 }

  has_many :comments
  has_and_belongs_to_many :roles
  has_many :news
  has_many :events

  scope :approved, -> { where(approved: true) }
end
