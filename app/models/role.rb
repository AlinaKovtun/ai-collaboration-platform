# frozen_string_literal: true

class Role < ApplicationRecord
  has_and_belongs_to_many :users

  scope :visible_to_users, -> { where.not(name: 'admin') }
end
