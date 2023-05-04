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
FactoryBot.define do
  factory :day_assignment do
    association :day
    association :plan
    completion { :zero }
    completed_at { nil }
  end
end
