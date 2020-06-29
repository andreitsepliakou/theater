# frozen_string_literal: true

class Spectacle < ApplicationRecord
  validates :title, :start_date, :end_date, presence: true
  validates :end_date, date: { after_or_equal_to: :start_date }, if: -> { start_date.present? && end_date.present? }
  validate :check_available_dates, if: -> { start_date.present? && end_date.present? && end_date >= start_date }

  private

  def check_available_dates
    intersection_condition = [
      '(:start_date BETWEEN start_date AND end_date)',
      '(:end_date BETWEEN start_date AND end_date)',
      '(start_date BETWEEN :start_date AND :end_date)'
    ].join(' OR ')
    return unless self.class.where(intersection_condition, start_date: start_date, end_date: end_date).exists?

    errors.add(:base, 'specified dates intersect with another spectacle')
  end
end
