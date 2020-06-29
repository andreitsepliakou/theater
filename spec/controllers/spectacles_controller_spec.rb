# frozen_string_literal: true

require 'rails_helper'

describe SpectaclesController do
  describe 'GET #index' do
    let(:spectacle) { create(:spectacle) }

    let(:serialized_spectacle) do
      {
        id: spectacle.id,
        title: spectacle.title,
        start_date: spectacle.start_date.to_s,
        end_date: spectacle.end_date.to_s
      }.stringify_keys
    end

    before do
      spectacle
    end

    it 'returns spectacles' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['records']).to eq([serialized_spectacle])
    end
  end

  describe 'POST #create' do
    let(:params) { { spectacle: serialized_spectacle_attributes } }

    let(:serialized_spectacle_attributes) do
      spectacle_attributes.stringify_keys.transform_values(&:to_s)
    end

    context 'when params are valid' do
      let(:spectacle_attributes) do
        {
          title: 'Romeo and Juliet',
          start_date: Date.new(2020, 9, 1),
          end_date: Date.new(2020, 9, 30)
        }
      end

      it 'creates a spectacle and returns it' do
        post :create, params: params

        expect(response).to have_http_status(:created)
        serialized_record = JSON.parse(response.body)['record']
        expect(serialized_record).to include(serialized_spectacle_attributes)
        expect(Spectacle.find(serialized_record['id'])).to have_attributes(spectacle_attributes)
      end
    end

    context 'when params are invalid' do
      let(:spectacle_attributes) do
        {
          title: '',
          start_date: Date.new(2020, 9, 30),
          end_date: Date.new(2020, 9, 1)
        }
      end

      it 'does not create a spectacle and returns errors' do
        expect { post :create, params: params }.not_to(change { Spectacle.count })

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:spectacle) { create(:spectacle) }

    before do
      spectacle
    end

    it 'deletes the spectacle' do
      delete :destroy, params: { id: spectacle.id }, format: :json

      expect(response).to have_http_status(:ok)
      expect(Spectacle.where(id: spectacle.id)).not_to exist
    end
  end
end
