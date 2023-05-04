# frozen_string_literal: true

# == Schema Information
#
# Table name: day_assignments
#
#  id           :bigint           not null, primary key
#  completed_at :datetime
#  completion   :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_id       :bigint
#  plan_id      :bigint
#
# Indexes
#
#  index_day_assignments_on_day_id   (day_id)
#  index_day_assignments_on_plan_id  (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#  fk_rails_...  (plan_id => plans.id)
#
class DayAssignment < ApplicationRecord
  belongs_to :day
  belongs_to :plan

  has_many :progression_assignemnts, dependent: :destroy

  COMPLETION_ENUM = {
    zero: 0,
    partial: 1,
    full: 2
  }.freeze

  enum completion: COMPLETION_ENUM
end
