# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable
  validates :first_name, :last_name, presence: true
  validates :description, length: { maximum: 500 }
end
