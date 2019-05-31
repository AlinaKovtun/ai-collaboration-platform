# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :participants, class_name: 'User', join_table: :events_participants

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, :venue, :event_start, :event_end, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }

  validate :event_end_after_event_start, :event_start_is_past_date,
           :event_end_is_past_date

  scope :upcoming_events, -> { where('event_start >= ?', Time.now).order(:event_start) }
  scope :next_events, ->(event) { upcoming_events.where.not(id: event.id).limit(3) }

  private

  def event_end_after_event_start
    return if event_end.blank? || event_start.blank?

    errors.add(:event_end, I18n.t('events.errors.after')) if event_end < event_start
  end

  def event_start_is_past_date
    return if event_start.blank?

    errors.add(:event_start, I18n.t('events.errors.future')) if event_start < Time.now
  end

  def event_end_is_past_date
    return if event_end.blank?

    errors.add(:event_end, I18n.t('events.errors.future')) if event_end < Time.now
  end
end
