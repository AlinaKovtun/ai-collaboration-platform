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
  has_one :email_change_request

  scope :approved, -> { where(approved: true) }

  attr_accessor :current_password

  def update_with_password(params, *options)
    current_password       = params[:current_password]
    password               = params[:password]
    _password_confirmation = params[:password_confirmation]
    if current_password.blank? || !password.blank?
      super
    else
      errors.add(:password, "can't be blank")
      false
    end
  end
end
