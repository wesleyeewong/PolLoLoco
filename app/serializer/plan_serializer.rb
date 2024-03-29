# frozen_string_literal: true

class PlanSerializer < BaseSerializer
  def call
    plan.as_json(
      only: %i[name id],
      include: {
        days: {
          only: [],
          include: {
            progressions: {
              only: %i[name id],
              include: {
                movement: {
                  only: [:slug]
                }
              }
            }
          }
        }
      }
    )
  end
end
