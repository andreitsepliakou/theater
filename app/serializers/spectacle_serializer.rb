# frozen_string_literal: true

class SpectacleSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date
end
