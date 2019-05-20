# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable, :async,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :about_me, length: { maximum: 500 }

  has_many :comments
  has_and_belongs_to_many :roles
  has_many :news
  has_many :events
  has_one :email_change_request
  has_many :project_participants
  has_many :projects, through: :project_participants
  has_many :owned_projects, class_name: 'Project', foreign_key: :author_id

  scope :by_roles, ->(role) { joins(:roles).where('roles_users.role_id': role) }
  scope :approved, -> { where(approved: true) }

  scope :find_users, (lambda do |search|
    where('first_name ILIKE lower(?) or
           last_name ILIKE lower(?)', "%#{search}%", "%#{search}%")
  end)

  attr_accessor :current_password

  def update_with_password(params, *options)
    if params[:current_password].present? && params[:password].blank?
      errors.add(:password, I18n.t('passwords.password.blank'))
      false
    else
      super
    end
  end

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email) do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.confirm
    end
  end

  %w[student expert mentor teacher admin].each do |role|
    define_method "#{role}?" do
      roles.any?(&:"#{role}?")
    end
  end
end
