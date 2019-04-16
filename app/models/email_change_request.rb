# frozen_string_literal: true

class EmailChangeRequest < ApplicationRecord
  belongs_to :user
  before_create :generate_token

  validates :email, presence: true
  validates_format_of :email, with: Devise.email_regexp

  def generate_token
    self.token = SecureRandom.uuid
  end
end
