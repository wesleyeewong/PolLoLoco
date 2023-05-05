# frozen_string_literal: true

class DayAssignmentsController < ApplicationController
  def current_day
    return head(:no_content) if Current.profile.plan.nil? || Current.profile.plan.days.count.zero?

    day_assignment = DetermineCurrentDay.new.call

    if day_assignment.new_record?
      ApplicationRecord.transaction do
        DetermineProgressionAssignments.new(day_assignment).call

        day_assignment.save!
      end
    end

    render json: DayAssignmentSerializer.new(day_assignment).call, status: :ok
  end
end
