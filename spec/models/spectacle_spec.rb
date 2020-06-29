# frozen_string_literal: true

require 'rails_helper'

describe Spectacle do
  subject { build_stubbed(:spectacle, start_date: start_date, end_date: end_date) }

  let(:start_date) { Date.new(2020, 9, 1) }
  let(:end_date) { Date.new(2020, 9, 30) }

  describe 'validations' do
    describe 'dates intersection' do
      let(:planned_spectacle_start_date) { Date.new(2020, 10, 10) }
      let(:planned_spectacle_end_date) { Date.new(2020, 10, 20) }

      before do
        create(:spectacle, start_date: planned_spectacle_start_date, end_date: planned_spectacle_end_date)
      end

      context 'when date range does not intersect with other spectacles' do
        let(:start_date) { Date.new(2020, 10, 1) }
        let(:end_date) { Date.new(2020, 10, 9) }

        it { is_expected.to be_valid }
      end

      context 'when date range intersects with the beginning of another spectacle' do
        let(:start_date) { Date.new(2020, 10, 5) }
        let(:end_date) { Date.new(2020, 10, 15) }

        it { is_expected.not_to be_valid }
      end

      context 'when date range intersects with the middle of another spectacle' do
        let(:start_date) { Date.new(2020, 10, 12) }
        let(:end_date) { Date.new(2020, 10, 17) }

        it { is_expected.not_to be_valid }
      end

      context 'when date range intersects with the end of another spectacle' do
        let(:start_date) { Date.new(2020, 10, 15) }
        let(:end_date) { Date.new(2020, 10, 25) }

        it { is_expected.not_to be_valid }
      end

      context 'when date range covers another spectacle' do
        let(:start_date) { Date.new(2020, 10, 1) }
        let(:end_date) { Date.new(2020, 10, 30) }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
