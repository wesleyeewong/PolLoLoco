# frozen_string_literal: true

# == Schema Information
#
# Table name: progression_assignments
#
#  id                :bigint           not null, primary key
#  reps              :integer          not null
#  rpe               :integer          default(0), not null
#  sets              :integer          not null
#  weight            :decimal(8, 3)    not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  day_assignment_id :bigint           not null
#  progression_id    :bigint
#
# Indexes
#
#  index_progression_assignments_on_day_assignment_id  (day_assignment_id)
#  index_progression_assignments_on_progression_id     (progression_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_assignment_id => day_assignments.id)
#  fk_rails_...  (progression_id => progressions.id)
#
class ProgressionAssignment < ApplicationRecord
  belongs_to :progression
  belongs_to :day_assignment

  has_many :completed_sets, dependent: :destroy

  def next_progression_hash
    { reps: next_reps, sets: next_sets, weight: next_weight, progression_id: progression.id }
  end

  private

  def next_reps
    return reps unless progress?

    next_reps = reps + progression.rep_increments
    next_reps = progression.min_reps if next_reps > progression.max_reps

    next_reps
  end

  def next_sets
    return sets unless progress?

    next_sets = sets
    next_sets += progression.set_increments if reps == progression.max_reps
    next_sets = progression.min_sets if next_sets > progression.max_sets

    next_sets
  end

  def next_weight
    return weight unless progress?

    next_weight = weight
    next_weight += progression.weight_increments if sets == progression.max_sets && reps == progression.max_reps

    next_weight
  end

  def progress?
    weight_multiplier = weight.zero? ? 1 : weight

    total_completed_weight >= (weight_multiplier * sets * reps)
  end

  def total_completed_weight
    @total_completed_weight ||= completed_sets.to_a.sum(0) do |cs|
      weight = cs.weight.zero? ? 1 : cs.weight
      weight * cs.reps
    end
  end
end
