# frozen_string_literal: true

FactoryBot.define do
  factory :spectacle do
    sequence(:title) { |n| "Romeo and Juliet #{n}" }
    start_date { Date.new(2020, 9, 1) }
    end_date { Date.new(2020, 9, 30) }
  end
end
