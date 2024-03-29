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
FactoryBot.define do
  factory :progression_assignment do
    association :progression
    association :day_assignment
    reps { 1 }
    sets { 1 }
    rpe { 1 }
    weight { 10 }

    trait :progressable do
      after(:create) do |pa|
        pa.sets.times { create(:completed_set, weight: pa.weight, reps: pa.reps, progression_assignment: pa) }
      end
    end

    trait :unprogressable_by_reps do
      after(:create) do |pa|
        pa.sets.times { create(:completed_set, weight: pa.weight, reps: pa.reps - 1, progression_assignment: pa) }
      end
    end

    trait :unprogressable_by_weight do
      after(:create) do |pa|
        pa.sets.times { create(:completed_set, weight: pa.weight - 1, reps: pa.reps, progression_assignment: pa) }
      end
    end
  end
end
