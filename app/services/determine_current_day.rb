class DetermineCurrentDay
  def call
    return new_day_assignment if build_new_day_assignment?

    last_day_assignment
  end

  private

  def new_day_assignment
    DayAssignment.new(profile:, plan: profile.plan, completion: :zero, day:)
  end

  def last_day_assignment
    @last_day_assignment ||= profile.plan.day_assignments.includes(:day).last
  end

  def build_new_day_assignment?
    genesis? || !last_day_assignment.for_current_day?
  end

  def genesis
    @genesis ||= last_day_assignment.nil?
  end
  alias_method :genesis?, :genesis


  def profile
    Current.profile
  end

  def day
    genesis? ? profile.plan.days.first : profile.plan.next_day(last_day_assignment.day)
  end
end
