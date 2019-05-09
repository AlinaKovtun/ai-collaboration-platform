# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable, :async
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :about_me, length: { maximum: 500 }

  has_many :comments
  has_many :news
  has_many :events
end
