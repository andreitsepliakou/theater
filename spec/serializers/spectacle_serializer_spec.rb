# frozen_string_literal: true

require 'rails_helper'

describe SpectacleSerializer do
  subject { described_class.new(spectacle).as_json }

  let(:spectacle) { build_stubbed(:spectacle) }

  its([:id]) { is_expected.to eq(spectacle.id) }
  its([:title]) { is_expected.to eq(spectacle.title) }
  its([:start_date]) { is_expected.to eq(spectacle.start_date) }
  its([:end_date]) { is_expected.to eq(spectacle.end_date) }
end
