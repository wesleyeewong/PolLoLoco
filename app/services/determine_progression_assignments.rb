class DetermineProgressionAssignments
  def initialize(day_assignment)
    @day_assignment = day_assignment
  end

  def call
    day_assignment.progression_assignments.build(
      progression_assignment_hashes
    )
  end

  private

  attr_reader :day_assignment

  def progression_assignment_hashes
    progressions.map do |progression|
      progression.last_progression_assignment&.next_progression_hash ||
        {
          reps: progression.initial_reps,
          sets: progression.initial_sets,
          weight: progression.initial_weight,
          progression_id: progression.id
        }
    end
  end

  def progressions
    @progressions ||= Progression
      .joins(:days)
      .includes(:movement, last_progression_assignment: [:completed_sets])
      .where(profile: Current.profile, days: [day_assignment.day])
  end
end
