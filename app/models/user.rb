# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable, :async
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :about_me, length: { maximum: 500 }

  has_many :news
  has_many :events
end
