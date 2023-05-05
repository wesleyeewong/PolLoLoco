# frozen_string_literal: true

# == Schema Information
#
# Table name: day_assignments
#
#  id           :bigint           not null, primary key
#  completed_at :datetime
#  completion   :integer          default("zero"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_id       :bigint
#  plan_id      :bigint
#  profile_id   :bigint           not null
#
# Indexes
#
#  index_day_assignments_on_day_id      (day_id)
#  index_day_assignments_on_plan_id     (plan_id)
#  index_day_assignments_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (profile_id => profiles.id)
#
class DayAssignment < ApplicationRecord
  belongs_to :profile
  belongs_to :day
  belongs_to :plan

  has_many :progression_assignments, dependent: :destroy

  COMPLETION_ENUM = {
    zero: 0,
    partial: 1,
    full: 2
  }.freeze

  enum :completion, COMPLETION_ENUM, suffix: true

  def for_current_day?
    case completion.to_sym
    when :zero, :partial
      true
    when :full
      completed_today?
    else
      false
    end
  end

  private

  def completed_today?
    return false unless completed_at

    Time.zone.today == completed_at.to_date
  end
end
