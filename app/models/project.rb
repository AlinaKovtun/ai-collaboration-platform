# frozen_string_literal: true

class Project < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  belongs_to :author, class_name: 'User'
  has_many :project_participants, dependent: :destroy
  has_many :users, through: :project_participants
end
