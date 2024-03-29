# frozen_string_literal: true

class ProgressionValidator < BaseValidator
  ATTRIBUTES = %i[
    name movement_id
    initial_reps initial_sets initial_weight
    max_reps max_sets min_reps min_sets
    rep_increments set_increments weight_increments
  ].freeze

  validates_presence_of(*ATTRIBUTES)

  validate :movement_existence

  private

  def movement_existence
    errors.add(:movement, :not_found) if Movement.find_by(id: params[:movement_id]).nil?
  end
end
