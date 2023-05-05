# frozen_string_literal: true

class DayAssignmentSerializer < BaseSerializer
  def call
    day_assignment.as_json(
      only: %i(id completed_at completion created_at),
      include: {
        progression_assignments: {
          only: %i(id reps sets weight rpe),
          include: {
            progression: {
              only: %i(id name),
              include: {
                movement: {
                  only: %i(slug)
                }
              }
            },
            completed_sets: {
              only: %i(id reps weight)
            }
          }
        }
      }
    )
  end
end
