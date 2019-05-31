# frozen_string_literal: true

class ProjectParticipant < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :project

  validates_uniqueness_of :user_id, scope: [:project_id]
end
