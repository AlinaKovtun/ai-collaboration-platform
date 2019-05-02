# frozen_string_literal: true

class Message
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :email, :body, :author_name

  validates_format_of :email, with: Devise.email_regexp
  validates :body, :author_name, presence: true
end
