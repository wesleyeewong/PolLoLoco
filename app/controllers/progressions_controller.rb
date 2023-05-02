# frozen_string_literal: true

class ProgressionsController < ApplicationController
  def index
    progressions = Current.profile.progressions.includes(:movement)

    render json: ProgressionSerializer.new(progressions).call, status: :ok
  end

  def create
    validator = ProgressionValidator.new(create_params)

    if validator.call
      progression = Current.profile.progressions.create!(create_params)

      render json: ProgressionSerializer.new(progression).call, status: :created
    else
      error(validator.errors)
    end
  end

  private

  def create_params
    params.permit(
      :name, :movement_id,
      :initial_reps, :initial_sets, :initial_weight,
      :max_reps, :max_sets, :min_reps, :min_sets,
      :rep_increments, :set_increments, :weight_increments
    )
  end
end
