# frozen_string_literal: true

class SpectaclesController < ApplicationController
  def index
    spectacles = ActiveModel::Serializer::CollectionSerializer.new(Spectacle.order(:start_date),
                                                                   serializer: SpectacleSerializer)
    render json: { records: spectacles.as_json }
  end

  def create
    spectacle = Spectacle.new(spectacle_params)

    if spectacle.save
      render json: { record: SpectacleSerializer.new(spectacle).as_json }, status: :created
    else
      render json: { errors: spectacle.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    Spectacle.find(params.fetch(:id)).destroy!
    head :ok
  end

  private

  def spectacle_params
    params.require(:spectacle).permit(:title, :start_date, :end_date)
  end
end
